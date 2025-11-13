# 2-09 | Workshop: From Prompts to Agents: Building & Evaluating R + LLM Workflows
**Devin Pastoor, Xu Fei & Aathira Anil Kumar (A2-AI)** | **3:00-5:00 PM** | **Day 2: Thursday, November 13, 2025**

## Abstract/Summary
**Workshop: From Prompts to Agents: Building & Evaluating R + LLM Workflows** - A comprehensive 2-hour hands-on workshop led by the A2-AI team focusing on the practical implementation of AI agents in R environments. This workshop covers the full spectrum from basic prompt engineering to sophisticated multi-agent systems, with emphasis on evaluation methodologies and production deployment strategies. Participants will learn to build, test, and deploy LLM-powered workflows that integrate seamlessly with R data science pipelines.

**Key Innovation**: End-to-end agent development framework in R, covering prompt engineering, agent architecture, evaluation frameworks, and production deployment patterns specifically designed for data science and analytics workflows.

## Conference Context
- **Position**: Day 2, Workshop (Final Session)
- **Time Slot**: 3:00-5:00 PM (2-hour workshop)
- **Instructors**: Devin Pastoor, Xu Fei & Aathira Anil Kumar (A2-AI)
- **Topic Focus**: Agent Development and Evaluation in R
- **Session Type**: Hands-on workshop with practical exercises

## Workshop Structure & Content
<!-- Live notes during workshop -->

### Pre-Workshop Context: Modern R Development Stack
**Live Chat Context**: During the workshop, participants discussed the modern R development stack, highlighting three complementary tools:

#### **rig - R Installation Manager**
- **Purpose**: Manages multiple R versions on your system
- **Repository**: https://github.com/r-lib/rig (829 stars)
- **Written in**: Rust (like rv and uv)
- **Key Features**:
  - Install/remove/switch between multiple R versions
  - Works on macOS, Windows, Linux
  - Creates quick links (e.g., `R-4.1`, `R-4.4`)
  - macOS menu bar app for easy version switching
  - Sets up package libraries and pak automatically
  - Supports symbolic names: `devel`, `release`, `oldrel`

#### **rv - Package Manager**
- **Purpose**: Manages R packages within projects (A2-AI's innovation)
- **Repository**: https://github.com/a2-ai/rv
- **Key Innovation**: Unlike renv's iterative approach, rv takes a **declarative** approach
- **Benefits over renv**: 
  - Resolves full dependency tree before installation (prevents incompatible versions)
  - 25x faster than traditional tools
  - Captures installation metadata at install time (not retroactively)
  - Can specify R version requirements in project config
- **Configuration**: Uses `rproject.toml` file (similar to Python's pyproject.toml)

#### **The Complete Stack**
**rig + rv + renv workflow**:
1. **rig**: Install and manage R versions system-wide
2. **rv** or **renv**: Manage project-specific package environments
3. **rv**: Modern declarative approach (A2-AI's recommendation)
4. **renv**: Traditional iterative approach (widely adopted)

**Example Modern R Workflow**:
```bash
# 1. Install and manage R versions with rig
rig add release          # Install latest R release
rig add devel           # Install R devel
rig list                # List installed versions
rig default 4.4         # Set default R version

# 2. Initialize project with rv (A2-AI approach)
rv init my-agent-project
cd my-agent-project

# 3. Configure project dependencies
```

**Example rproject.toml configuration**:
```toml
[project]
name = "my-agent-project"
r_version = "4.4"  # Managed by rig

repositories = [
    { alias = "PPM", url = "https://packagemanager.posit.co/cran/latest" }
]

dependencies = [
    "httr2",
    "jsonlite", 
    "R6",
    { name = "tidyverse", install_suggestions = false }
]
```

```bash
# 4. Synchronize project environment
rv sync                 # Install/update all dependencies

# Alternative: Traditional renv approach
# renv::init()
# renv::install(c("httr2", "jsonlite", "R6", "tidyverse"))
# renv::snapshot()
```

### Session 1: Foundations (3:00-3:30 PM)
**Prompt Engineering Fundamentals**:
- **Prompt Design Principles**: Clarity, specificity, context management
- **R-Specific Prompting**: Code generation, data analysis, statistical modeling
- **Template Systems**: Reusable prompt structures for common R tasks
- **Context Window Management**: Efficient use of token limits for R workflows

**Setting Up Development Environment**:
```r
# Workshop setup - R packages and dependencies
install.packages(c(
  "httr2",      # HTTP client for API calls
  "jsonlite",   # JSON processing
  "tidyverse",  # Data manipulation and visualization
  "reticulate", # Python integration
  "testthat",   # Testing framework
  "logger",     # Logging and monitoring
  "future",     # Parallel processing
  "promises"    # Asynchronous programming
))

# A2-AI specific packages (if available)
# devtools::install_github("a2-ai/r-agent-toolkit")
# devtools::install_github("a2-ai/llm-eval-r")

# OpenAI API setup
library(httr2)
library(jsonlite)

# Basic OpenAI client setup
setup_openai_client <- function(api_key = Sys.getenv("OPENAI_API_KEY")) {
  if (api_key == "") {
    stop("OpenAI API key not found. Set OPENAI_API_KEY environment variable.")
  }
  
  client <- list(
    api_key = api_key,
    base_url = "https://api.openai.com/v1",
    default_model = "gpt-4"
  )
  
  class(client) <- "openai_client"
  return(client)
}

# Basic prompt execution function
execute_prompt <- function(client, prompt, model = NULL) {
  model <- model %||% client$default_model
  
  response <- request(paste0(client$base_url, "/chat/completions")) %>%
    req_headers(Authorization = paste("Bearer", client$api_key)) %>%
    req_body_json(list(
      model = model,
      messages = list(list(
        role = "user",
        content = prompt
      )),
      temperature = 0.1
    )) %>%
    req_perform() %>%
    resp_body_json()
  
  return(response$choices[[1]]$message$content)
}
```

### Session 2: Agent Architecture (3:30-4:00 PM)
**Agent Design Patterns**:
- **Single-Purpose Agents**: Focused agents for specific R tasks
- **Multi-Agent Systems**: Coordinated agents for complex workflows
- **Agent Communication**: Message passing and state management
- **Tool Integration**: Connecting agents with R functions and external APIs

**Basic Agent Implementation**:
```r
# Define R Agent base class
R6Agent <- R6::R6Class("R6Agent",
  public = list(
    name = NULL,
    description = NULL,
    tools = list(),
    client = NULL,
    memory = list(),
    
    initialize = function(name, description, client, tools = list()) {
      self$name <- name
      self$description <- description
      self$client <- client
      self$tools <- tools
      self$memory <- list()
    },
    
    add_tool = function(tool_name, tool_function, tool_description) {
      self$tools[[tool_name]] <- list(
        function = tool_function,
        description = tool_description
      )
    },
    
    execute_task = function(task, context = NULL) {
      # Prepare system prompt with agent description and available tools
      system_prompt <- self$build_system_prompt()
      
      # Prepare user message with task and context
      user_message <- self$build_user_message(task, context)
      
      # Execute with LLM
      response <- self$llm_call(system_prompt, user_message)
      
      # Parse and execute any tool calls
      result <- self$process_response(response)
      
      # Update memory
      self$memory <- append(self$memory, list(
        task = task,
        context = context,
        response = response,
        result = result,
        timestamp = Sys.time()
      ))
      
      return(result)
    },
    
    build_system_prompt = function() {
      tools_desc <- if (length(self$tools) > 0) {
        paste("Available tools:", 
              paste(names(self$tools), sapply(self$tools, `[[`, "description"), 
                    sep = ": ", collapse = "\n"))
      } else {
        "No tools available."
      }
      
      paste(
        paste("You are", self$description),
        "You work with R and data science workflows.",
        tools_desc,
        "Provide clear, executable R code when appropriate.",
        sep = "\n\n"
      )
    },
    
    build_user_message = function(task, context) {
      message <- paste("Task:", task)
      if (!is.null(context)) {
        message <- paste(message, "\nContext:", toJSON(context, auto_unbox = TRUE))
      }
      return(message)
    },
    
    llm_call = function(system_prompt, user_message) {
      # Implementation depends on LLM provider
      # This is a simplified version
      full_prompt <- paste(system_prompt, "\n\nUser:", user_message)
      return(execute_prompt(self$client, full_prompt))
    },
    
    process_response = function(response) {
      # Parse response for tool calls and execute them
      # This would include more sophisticated parsing in practice
      
      # Check if response contains R code
      if (grepl("```r", response)) {
        code_blocks <- stringr::str_extract_all(response, "```r\\n(.*?)\\n```")[[1]]
        
        results <- list()
        for (code_block in code_blocks) {
          # Extract code content
          code <- gsub("```r\\n|\\n```", "", code_block)
          
          # Execute in safe environment (in practice, would use more security)
          tryCatch({
            result <- eval(parse(text = code))
            results <- append(results, list(result))
          }, error = function(e) {
            results <- append(results, list(paste("Error:", e$message)))
          })
        }
        
        return(list(
          response_text = response,
          code_results = results
        ))
      }
      
      return(list(response_text = response))
    }
  )
)

# Example: Data Analysis Agent
create_data_analyst_agent <- function(client) {
  agent <- R6Agent$new(
    name = "DataAnalyst",
    description = "a data analysis specialist that helps with R data science tasks",
    client = client
  )
  
  # Add data summary tool
  agent$add_tool(
    "summarize_data",
    function(data) {
      if (is.data.frame(data)) {
        return(summary(data))
      } else {
        return("Input is not a data frame")
      }
    },
    "Summarize a data frame with descriptive statistics"
  )
  
  # Add visualization tool
  agent$add_tool(
    "create_plot",
    function(data, x_var, y_var = NULL, plot_type = "scatter") {
      library(ggplot2)
      
      if (is.null(y_var)) {
        # Univariate plot
        if (plot_type == "histogram") {
          return(ggplot(data, aes_string(x = x_var)) + geom_histogram())
        } else {
          return(ggplot(data, aes_string(x = x_var)) + geom_bar())
        }
      } else {
        # Bivariate plot
        if (plot_type == "scatter") {
          return(ggplot(data, aes_string(x = x_var, y = y_var)) + geom_point())
        } else if (plot_type == "line") {
          return(ggplot(data, aes_string(x = x_var, y = y_var)) + geom_line())
        }
      }
    },
    "Create visualizations from data"
  )
  
  return(agent)
}
```

### Session 3: Multi-Agent Systems (4:00-4:30 PM)
**Agent Orchestration**:
- **Workflow Coordination**: Managing agent interactions and dependencies
- **State Management**: Shared state between agents
- **Error Handling**: Robust error recovery in multi-agent systems
- **Performance Optimization**: Parallel agent execution

**Multi-Agent Implementation**:
```r
# Multi-Agent Coordinator
AgentCoordinator <- R6::R6Class("AgentCoordinator",
  public = list(
    agents = list(),
    shared_state = list(),
    execution_log = list(),
    
    initialize = function() {
      self$agents <- list()
      self$shared_state <- list()
      self$execution_log <- list()
    },
    
    add_agent = function(agent) {
      self$agents[[agent$name]] <- agent
    },
    
    execute_workflow = function(workflow_spec) {
      # workflow_spec defines the sequence of agent tasks
      results <- list()
      
      for (step in workflow_spec) {
        agent_name <- step$agent
        task <- step$task
        context <- step$context
        
        # Add shared state to context
        if (!is.null(context)) {
          context$shared_state <- self$shared_state
        } else {
          context <- list(shared_state = self$shared_state)
        }
        
        # Execute task with specified agent
        if (agent_name %in% names(self$agents)) {
          result <- self$agents[[agent_name]]$execute_task(task, context)
          results[[paste0(agent_name, "_", length(results) + 1)]] <- result
          
          # Update shared state if needed
          if (!is.null(step$update_shared_state)) {
            self$shared_state <- step$update_shared_state(self$shared_state, result)
          }
          
          # Log execution
          self$execution_log <- append(self$execution_log, list(
            step = length(self$execution_log) + 1,
            agent = agent_name,
            task = task,
            result = result,
            timestamp = Sys.time()
          ))
        } else {
          stop(paste("Agent", agent_name, "not found"))
        }
      }
      
      return(results)
    },
    
    get_execution_summary = function() {
      return(data.frame(
        step = sapply(self$execution_log, `[[`, "step"),
        agent = sapply(self$execution_log, `[[`, "agent"),
        task = sapply(self$execution_log, `[[`, "task"),
        timestamp = sapply(self$execution_log, `[[`, "timestamp"),
        stringsAsFactors = FALSE
      ))
    }
  )
)

# Example: Data Science Workflow
setup_data_science_workflow <- function(client) {
  coordinator <- AgentCoordinator$new()
  
  # Add specialized agents
  data_agent <- create_data_analyst_agent(client)
  
  # Statistical modeling agent
  stats_agent <- R6Agent$new(
    name = "StatisticsAgent",
    description = "a statistical modeling specialist that builds and evaluates models",
    client = client
  )
  
  # Reporting agent
  report_agent <- R6Agent$new(
    name = "ReportingAgent", 
    description = "a reporting specialist that creates documentation and summaries",
    client = client
  )
  
  coordinator$add_agent(data_agent)
  coordinator$add_agent(stats_agent)
  coordinator$add_agent(report_agent)
  
  return(coordinator)
}
```

### Session 4: Evaluation Framework (4:30-4:50 PM)
**Evaluation Methodologies**:
- **Performance Metrics**: Speed, accuracy, resource utilization
- **Quality Assessment**: Output quality, consistency, reliability
- **A/B Testing**: Comparing different agent configurations
- **Automated Testing**: Unit tests for agent components

**Evaluation Implementation**:
```r
# Agent Evaluation Framework
AgentEvaluator <- R6::R6Class("AgentEvaluator",
  public = list(
    test_cases = list(),
    evaluation_results = list(),
    
    initialize = function() {
      self$test_cases <- list()
      self$evaluation_results <- list()
    },
    
    add_test_case = function(name, task, expected_result = NULL, evaluation_function = NULL) {
      self$test_cases[[name]] <- list(
        task = task,
        expected_result = expected_result,
        evaluation_function = evaluation_function
      )
    },
    
    evaluate_agent = function(agent, test_case_names = NULL) {
      if (is.null(test_case_names)) {
        test_case_names <- names(self$test_cases)
      }
      
      results <- list()
      
      for (test_name in test_case_names) {
        test_case <- self$test_cases[[test_name]]
        
        # Execute test
        start_time <- Sys.time()
        
        tryCatch({
          result <- agent$execute_task(test_case$task)
          end_time <- Sys.time()
          execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
          
          # Evaluate result
          evaluation <- if (!is.null(test_case$evaluation_function)) {
            test_case$evaluation_function(result, test_case$expected_result)
          } else {
            list(score = NA, details = "No evaluation function provided")
          }
          
          results[[test_name]] <- list(
            test_name = test_name,
            result = result,
            expected = test_case$expected_result,
            execution_time = execution_time,
            evaluation = evaluation,
            success = TRUE,
            error = NULL
          )
          
        }, error = function(e) {
          end_time <- Sys.time()
          execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
          
          results[[test_name]] <- list(
            test_name = test_name,
            result = NULL,
            expected = test_case$expected_result,
            execution_time = execution_time,
            evaluation = list(score = 0, details = paste("Error:", e$message)),
            success = FALSE,
            error = e$message
          )
        })
      }
      
      # Store results
      self$evaluation_results[[agent$name]] <- results
      
      return(results)
    },
    
    generate_evaluation_report = function(agent_name = NULL) {
      if (is.null(agent_name)) {
        # Report on all agents
        all_results <- self$evaluation_results
      } else {
        all_results <- list(self$evaluation_results[[agent_name]])
        names(all_results) <- agent_name
      }
      
      report_data <- list()
      
      for (agent in names(all_results)) {
        agent_results <- all_results[[agent]]
        
        # Calculate summary statistics
        success_rate <- mean(sapply(agent_results, `[[`, "success"))
        avg_execution_time <- mean(sapply(agent_results, `[[`, "execution_time"))
        avg_score <- mean(sapply(agent_results, function(x) x$evaluation$score), na.rm = TRUE)
        
        report_data[[agent]] <- list(
          agent_name = agent,
          total_tests = length(agent_results),
          success_rate = success_rate,
          avg_execution_time = avg_execution_time,
          avg_score = avg_score,
          detailed_results = agent_results
        )
      }
      
      return(report_data)
    }
  )
)

# Example evaluation functions
create_code_quality_evaluator <- function() {
  function(result, expected) {
    # Evaluate R code quality
    code_text <- if (is.list(result) && "response_text" %in% names(result)) {
      result$response_text
    } else {
      as.character(result)
    }
    
    # Simple quality metrics
    has_comments <- grepl("#", code_text)
    has_proper_spacing <- !grepl("[a-zA-Z]\\(|\\)[a-zA-Z]", code_text)
    uses_good_names <- !grepl("\\b(x|y|z|data1|temp)\\b", code_text)
    
    quality_score <- (as.numeric(has_comments) + 
                     as.numeric(has_proper_spacing) + 
                     as.numeric(uses_good_names)) / 3
    
    return(list(
      score = quality_score,
      details = list(
        has_comments = has_comments,
        has_proper_spacing = has_proper_spacing,
        uses_good_names = uses_good_names
      )
    ))
  }
}
```

### Session 5: Production Deployment (4:50-5:00 PM)
**Deployment Strategies**:
- **Containerization**: Docker deployment for R + LLM agents
- **Scaling**: Horizontal scaling with load balancing
- **Monitoring**: Performance monitoring and alerting
- **Security**: API security and access control

**Production Setup**:
```r
# Production Agent Manager
ProductionAgentManager <- R6::R6Class("ProductionAgentManager",
  public = list(
    agents = list(),
    request_queue = list(),
    performance_metrics = list(),
    
    initialize = function() {
      self$agents <- list()
      self$request_queue <- list()
      self$performance_metrics <- list()
    },
    
    deploy_agent = function(agent, config = list()) {
      # Add production configuration
      agent$production_config <- config
      agent$metrics <- list(
        requests_processed = 0,
        total_execution_time = 0,
        error_count = 0
      )
      
      self$agents[[agent$name]] <- agent
      
      # Initialize monitoring
      self$setup_monitoring(agent$name)
    },
    
    process_request = function(agent_name, task, priority = "normal") {
      if (!agent_name %in% names(self$agents)) {
        stop(paste("Agent", agent_name, "not deployed"))
      }
      
      request_id <- paste0("req_", Sys.time(), "_", sample(1000:9999, 1))
      
      # Add to queue
      self$request_queue[[request_id]] <- list(
        id = request_id,
        agent_name = agent_name,
        task = task,
        priority = priority,
        timestamp = Sys.time(),
        status = "queued"
      )
      
      # Process request
      result <- self$execute_request(request_id)
      
      return(result)
    },
    
    execute_request = function(request_id) {
      request <- self$request_queue[[request_id]]
      agent <- self$agents[[request$agent_name]]
      
      # Update status
      self$request_queue[[request_id]]$status <- "processing"
      
      # Execute with monitoring
      start_time <- Sys.time()
      
      tryCatch({
        result <- agent$execute_task(request$task)
        end_time <- Sys.time()
        execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
        
        # Update metrics
        agent$metrics$requests_processed <- agent$metrics$requests_processed + 1
        agent$metrics$total_execution_time <- agent$metrics$total_execution_time + execution_time
        
        # Update request status
        self$request_queue[[request_id]]$status <- "completed"
        self$request_queue[[request_id]]$result <- result
        self$request_queue[[request_id]]$execution_time <- execution_time
        
        return(list(
          request_id = request_id,
          status = "success",
          result = result,
          execution_time = execution_time
        ))
        
      }, error = function(e) {
        # Update error metrics
        agent$metrics$error_count <- agent$metrics$error_count + 1
        
        # Update request status
        self$request_queue[[request_id]]$status <- "error"
        self$request_queue[[request_id]]$error <- e$message
        
        return(list(
          request_id = request_id,
          status = "error",
          error = e$message
        ))
      })
    },
    
    setup_monitoring = function(agent_name) {
      # Initialize performance tracking
      self$performance_metrics[[agent_name]] <- list(
        start_time = Sys.time(),
        requests_per_minute = 0,
        avg_response_time = 0,
        error_rate = 0
      )
    },
    
    get_agent_status = function(agent_name = NULL) {
      if (is.null(agent_name)) {
        # Return status for all agents
        return(lapply(names(self$agents), function(name) {
          agent <- self$agents[[name]]
          list(
            name = name,
            metrics = agent$metrics,
            performance = self$performance_metrics[[name]]
          )
        }))
      } else {
        agent <- self$agents[[agent_name]]
        return(list(
          name = agent_name,
          metrics = agent$metrics,
          performance = self$performance_metrics[[agent_name]]
        ))
      }
    }
  )
)
```

## Hands-On Exercises
<!-- Workshop exercises and solutions -->

### Exercise 1: Basic Agent Creation (3:30 PM)
**Task**: Create a simple R data analysis agent
**Objective**: Build an agent that can summarize datasets and create basic visualizations

### Exercise 2: Multi-Agent Workflow (4:00 PM)
**Task**: Design a multi-agent system for a complete data science workflow
**Objective**: Coordinate multiple agents to handle data preprocessing, analysis, and reporting

### Exercise 3: Agent Evaluation (4:30 PM)  
**Task**: Implement evaluation metrics for agent performance
**Objective**: Build automated testing and quality assessment for agent outputs

### Exercise 4: Production Deployment (4:50 PM)
**Task**: Deploy agents in a production-ready configuration
**Objective**: Set up monitoring, error handling, and scaling capabilities

## Research Implications

### Agent-Based R Development
**Paradigm Shift**: Moving from traditional R scripting to agent-based development represents a fundamental shift in how data science workflows are conceived and implemented. This approach offers several advantages:

- **Modularity**: Agents encapsulate specific functionality, making complex workflows more manageable
- **Reusability**: Well-designed agents can be reused across different projects and contexts
- **Scalability**: Agent-based systems can scale horizontally by deploying multiple agent instances
- **Maintainability**: Individual agents can be updated and maintained independently

### Evaluation Framework Innovation
**Systematic Assessment**: The workshop's emphasis on evaluation frameworks addresses a critical gap in AI agent development. Key innovations include:

- **Multi-dimensional Evaluation**: Assessing agents on performance, quality, reliability, and resource efficiency
- **Automated Testing**: Continuous evaluation of agent performance as they evolve
- **Comparative Analysis**: A/B testing frameworks for optimizing agent configurations
- **Production Monitoring**: Real-time performance tracking and alerting systems

### R Ecosystem Integration
**Seamless Integration**: The workshop demonstrates how LLM agents can integrate naturally with the R ecosystem:

- **Package Ecosystem**: Leveraging existing R packages within agent workflows
- **Data Pipelines**: Integrating agents into established R data processing pipelines  
- **Visualization**: Agent-generated insights feeding into R's rich visualization capabilities
- **Statistical Modeling**: Agents that can build, evaluate, and interpret statistical models

### Future Directions
**Research Opportunities**:
- **Domain-Specific Agents**: Specialized agents for specific statistical or analytical domains
- **Collaborative Intelligence**: Human-agent collaboration patterns in data science
- **Meta-Learning Agents**: Agents that learn and adapt their strategies over time
- **Ethical AI Integration**: Frameworks for ensuring responsible AI use in data science

## Q&A Session
<!-- Questions and responses from workshop participants -->

## Questions for Further Investigation
**Technical Implementation**:
- What are the performance characteristics of different agent architectures in R?
- How do evaluation metrics correlate with real-world agent effectiveness?
- What are the optimal deployment patterns for different types of R agents?
- Integration strategies with existing R development workflows and tools?

**A2-AI Framework Specifics**:
- What specific innovations does A2-AI bring to agent development in R?
- How does the A2-AI evaluation framework compare to other approaches?
- Licensing and availability of A2-AI tools and frameworks?
- Case studies of successful A2-AI agent deployments?

**AI Assistant Configuration & Development**:
- How to create effective CLAUDE.md files for R projects?
- Best practices for AI assistant guidance in complex R codebases?
- Implementation of AI-specific documentation patterns (`.claude/ai-references/`)?
- Integration of AI assistants in R development workflows and testing?
- Usage of Claude's Agent Skills and computer use tools for R automation?
- Development of custom tools for R-specific AI agent tasks?

**Scaling and Production**:
- Resource requirements for running LLM agents at scale in R environments?
- Cost-benefit analysis of agent-based vs. traditional R development approaches?
- Security considerations for production agent deployments?
- Integration with enterprise R environments (RStudio Connect, Posit Workbench)?

**Evaluation and Quality Assurance**:
- Best practices for defining evaluation metrics for R-specific tasks?
- Handling edge cases and unexpected inputs in agent evaluation?
- Longitudinal studies of agent performance and reliability?
- Human evaluation vs. automated evaluation trade-offs?

**Development Workflow Integration**:
- Version control strategies for agent-based R projects?
- Testing frameworks specifically designed for R agents?
- Documentation and knowledge management for agent-based systems?
- Team collaboration patterns when developing agent-based R solutions?

**Domain-Specific Applications**:
- Agent architectures optimized for specific domains (bioinformatics, finance, etc.)?
- Handling domain-specific R packages and specialized statistical methods?
- Compliance and regulatory considerations for agent-based analytics?
- Performance optimization for computationally intensive R workflows?

## Resources & References
### Workshop Materials
**A2-AI Team**:
- **Devin Pastoor, PhD**
  - **Position**: Chief Technology & Product Officer (CTPO)
  - **Institution**: A2-AI
  - **Location**: Rockville, MD
  - **Expertise**: End-to-end solutions for quantitative decision-making, bridging IT infrastructure with scientific teams, cloud-based workflows, data science solutions
  - **Background**: Principal solutions engineer helping dozens of organizations (FDA to small biotech) develop and implement data science solutions
  - **GitHub**: https://github.com/dpastoor (369 repositories, 210 followers)
    - **Key Projects**: qvm (Go version manager), awesome-shiny (R Shiny resources), PKPDdatasets (pharmacokinetic/pharmacodynamic datasets), nonmemutils (NONMEM utilities in Go)
    - **Organizations**: A2-ai, r-infra
    - **Focus Areas**: R, Go, Rust, Python, pharmacometrics, cloud infrastructure, package management
  - **LinkedIn**: https://www.linkedin.com/in/devinpastoor/ (profile private)
  - **A2-AI Profile**: https://a2-ai.com/leadership/devin-pastoor
  - **Contact**: Available through A2-AI leadership page

- **Xu Fei** 
  - **Position**: [To be confirmed during workshop]
  - **Institution**: A2-AI
  - **Previous Talk**: "Tracking the Evolution of R and Python Tools for GenAI" (2-04)
  - **Expertise**: [To be confirmed during workshop]
  - **Contact**: [To be confirmed during workshop]

- **Aathira Anil Kumar**
  - **Position**: [To be confirmed during workshop]
  - **Institution**: A2-AI
  - **Expertise**: [To be confirmed during workshop]
  - **Contact**: [To be confirmed during workshop]

**Workshop Repository**:
- **Code Examples**: [Workshop code repository to be confirmed]
- **Exercises**: [Hands-on exercise materials and solutions]
- **Reference Implementation**: [Complete agent framework implementation]
- **Documentation**: [Setup instructions and troubleshooting guide]

### Conference Context
**R+AI 2025 Conference**:
- **Event**: Inaugural R+AI conference, November 12-13, 2025
- **Format**: 100% online with recorded presentations and live Q&A
- **Organizer**: R Consortium
- **Focus**: Integration of R programming language with artificial intelligence technologies
- **Call for Proposals**: https://r-consortium.org/posts/r_plus_ai_call_for_proposals/

**A2-AI Context**:
- **Company Focus**: AI-first data science and analytics solutions
- **R Ecosystem Involvement**: Active development of R-based AI tools and frameworks
- **Key Innovation**: **rv** - Next-generation R package manager written in Rust
- **rv Package Manager**: 
  - **Repository**: https://github.com/a2-ai/rv
  - **Documentation**: https://a2-ai.github.io/rv-docs/
  - **Key Features**: Declarative package management, 25x faster than traditional tools, Rust-based performance
  - **Configuration**: Uses `rproject.toml` for declarative dependency specification

### Technical Resources
**AI Assistant Configuration Files**:
- **CLAUDE.md**: AI assistant guidance file for development environments
  - **Purpose**: Provides context and instructions to Claude AI when working on code
  - **Location**: Root of rv repository (https://github.com/A2-ai/rv/blob/main/CLAUDE.md)
  - **Content**: Development commands, project architecture, key dependencies, code locations
  - **Usage**: Helps AI assistants understand project structure and development patterns
  - **Key Sections**: Build commands, testing setup, dependency resolution, file locations
  
- **AI References Directory**: `.claude/ai-references/`
  - **Purpose**: Specific technical documentation for AI assistant consumption
  - **Example**: `configure-repo.md` - Implementation patterns for repository configuration
  - **Pattern**: Focused, implementation-specific guidance for complex features
  - **Benefits**: Prevents AI from making assumptions, provides authoritative implementation details

**Positron IDE AI Assistant System** (Enterprise-Scale Example):
- **Main Configuration**: `CLAUDE.md` in root directory (https://github.com/posit-dev/positron/blob/main/CLAUDE.md)
  - **Project Context**: Complete development environment setup and communication guidelines
  - **Build System**: Critical daemon management requirements and workflows
  - **Code Organization**: Upstream compatibility rules and merge conflict prevention
  - **Architecture**: VS Code fork with Positron-specific enhancements
  
- **Modular Prompt System**: `.claude/` directory with specialized documentation
  - **launch-positron.md**: Non-blocking launch protocols for AI sessions
  - **build-system.md**: Detailed daemon management and compilation monitoring
  - **data-explorer.md**: Data viewing and exploration features
  - **e2e-testing.md**: Playwright end-to-end testing workflows  
  - **positron-duckdb.md**: DuckDB extension development
  - **positron-python.md**: Python language support integration
  - **Plus**: commands/, hooks/, skills/ subdirectories for specialized tooling

- **Key Design Patterns**:
  - **Communication Guidelines**: Professional, direct language avoiding sycophancy
  - **Critical Requirements**: Build daemon status checks before any development work
  - **Non-blocking Operations**: Background process launches to maintain AI session availability
  - **Upstream Compatibility**: Strict code organization rules for VS Code merge compatibility
  - **Modular Context**: Task-specific documentation files to minimize token usage

- **Production Scale Features**:
  - **Daemon Management**: Real-time monitoring of compilation processes
  - **Testing Integration**: Extension tests and E2E Playwright test coordination
  - **Development Workflows**: Complete setup, build, test, and deployment pipelines
  - **Code Quality**: Automatic formatting, linting, and contribution guidelines
  - **Error Handling**: Comprehensive troubleshooting and problem resolution guides

- **AGENTS.md**: Not found in rv repository (may be project-specific or different naming)
  - **Alternative**: Consider Claude's Agent Skills and computer use tools
  - **Documentation**: https://docs.anthropic.com/claude/docs/agents-and-tools/
  - **Tools**: Computer use, text editor, bash tools for agent development

**Modern R Development Stack**:
- **rig**: R Installation Manager (r-lib/rig)
  - **Installation**: Multiple options (installer, Homebrew, Scoop, apt, yum)
  - **Key Commands**: `rig add release`, `rig list`, `rig default`, `rig switch`
  - **Purpose**: System-wide R version management
  - **Benefits**: Multiple R versions, quick links, automatic pak setup
  - **Platform Support**: macOS, Windows, Linux (including ARM64)

- **rv**: Next-generation R package manager (A2-AI)
  - **Installation**: See https://a2-ai.github.io/rv-docs/intro/installation/
  - **Key Commands**: `rv init`, `rv sync`, `rv plan`
  - **Configuration**: Declarative `rproject.toml` file
  - **Benefits**: 25x faster, resolves full dependency tree, prevents version conflicts
  - **vs renv**: Declarative (vs iterative), captures install metadata immediately

- **renv**: Traditional R package manager
  - **Approach**: Iterative installation with retrospective snapshots
  - **Widely adopted**: Established in R ecosystem
  - **Integration**: Works seamlessly with rig for R version management

**LLM Integration Packages**:
- **httr2**: Modern HTTP client for R API interactions
- **jsonlite**: Fast JSON parser and generator for R
- **reticulate**: R interface to Python for accessing Python-based LLM libraries
- **future**: Unified parallel and distributed processing in R
- **promises**: Promise-based asynchronous programming for R
- **vitals**: Large Language Model evaluation framework (port of Python's Inspect)
  - **Purpose**: LLM evaluation specifically for ellmer users measuring product effectiveness
  - **Repository**: https://cran.r-project.org/package=vitals
  - **Key Features**: Prompt engineering evaluation, tool usage assessment, multi-turn dialog testing, model-graded evaluations
  - **Core Components**: Datasets (input/target pairs), Solvers (AI products), Scorers (evaluation methods)
  - **Evaluation Types**: Deterministic scoring, LLM-as-a-judge, human grading
  - **Built-in Dataset**: `are` - R coding problems for expert-level evaluation
  - **Dependencies**: ellmer, dplyr, ggplot2, R6, S7, cli, glue, jsonlite, purrr
  - **Integration**: Interactive Inspect log viewer for result analysis
  - **Usage**: `Task$new(dataset, solver, scorer) |> Task$eval()` for evaluation workflows

**Agent Development Frameworks**:
- **R6**: Encapsulated object-oriented programming for R
- **testthat**: Unit testing framework for R packages
- **logger**: Flexible logging framework for R applications
- **config**: Manage environment specific configuration values
- **pool**: Database connection pooling for Shiny applications

**Evaluation and Monitoring**:
- **microbenchmark**: Accurate timing functions for R expressions
- **profvis**: Interactive visualizations for profiling R code
- **shiny**: Web applications for interactive agent monitoring
- **DT**: Interactive data tables for evaluation results
- **plotly**: Interactive visualizations for performance metrics

**Production Deployment**:
- **plumber**: Create web APIs from R functions
- **docker**: Containerization for R applications
- **kubernetes**: Container orchestration for scalable deployments
- **prometheus**: Monitoring and alerting toolkit
- **grafana**: Analytics and interactive visualization web application

### Related Academic & Technical References
**Agent-Based Systems**:
- Multi-agent systems design principles and architectures
- Agent communication protocols and coordination mechanisms
- Distributed systems design patterns for agent deployment
- Software engineering practices for agent-based applications

**LLM Integration**:
- Large language model API integration patterns
- Prompt engineering techniques and best practices
- Context management and memory systems for conversational agents
- Performance optimization for LLM-based applications

**R Development Best Practices**:
- R package development and testing methodologies
- Object-oriented programming patterns in R
- Production R deployment strategies and monitoring
- R performance optimization and parallel processing

**Evaluation Methodologies**:
- Software testing frameworks and methodologies
- AI system evaluation metrics and benchmarks
- A/B testing for AI applications
- Quality assurance practices for ML/AI systems

### Related Tools & Frameworks
**AI Assistant Development Resources**:
- **Claude Documentation**: https://docs.anthropic.com/claude/docs
  - **Agent Skills**: https://docs.anthropic.com/claude/docs/agents-and-tools/agent-skills/overview
  - **Computer Use Tool**: https://docs.anthropic.com/claude/docs/agents-and-tools/tool-use/computer-use-tool
  - **Tool Use Guide**: https://docs.anthropic.com/claude/docs/agents-and-tools/tool-use/overview

- **Production Examples**:
  - **A2-AI rv Package Manager**: https://github.com/A2-ai/rv/blob/main/CLAUDE.md
    - **AI References**: https://github.com/A2-ai/rv/tree/main/.claude/ai-references
  - **Posit Positron IDE**: https://github.com/posit-dev/positron/blob/main/CLAUDE.md
    - **Modular System**: https://github.com/posit-dev/positron/tree/main/.claude
    - **Launch Protocol**: https://github.com/posit-dev/positron/blob/main/.claude/launch-positron.md
    - **Build System**: https://github.com/posit-dev/positron/blob/main/.claude/build-system.md

- **Enterprise-Scale Best Practices** (from Positron):
  - **Main CLAUDE.md**: Project overview, communication guidelines, critical requirements
  - **Modular Documentation**: Task-specific `.claude/<feature>.md` files to reduce token usage
  - **Non-blocking Protocols**: Background process management to maintain AI session availability
  - **Code Organization Rules**: Upstream compatibility and merge conflict prevention
  - **Communication Standards**: Professional, direct language avoiding AI sycophantic responses
  - **Build System Integration**: Real-time daemon monitoring and compilation status
  - **Testing Coordination**: Extension and E2E test automation with AI assistance
  - **Development Workflows**: Complete setup, build, test, and deployment automation

- **Implementation Patterns**:
  - Create project-specific CLAUDE.md files with development commands and architecture
  - Use `.claude/` directory for specialized documentation (modular prompts)
  - Implement non-blocking launch protocols for long-running development processes
  - Include critical system requirements and dependency management
  - Provide clear, factual instructions without assumptions
  - Structure documentation for minimal token usage and maximum context efficiency

**Alternative Agent Frameworks**:
- **LangChain**: Framework for developing applications with language models
- **AutoGen**: Multi-agent conversation framework
- **CrewAI**: Framework for orchestrating role-playing autonomous AI agents
- **Semantic Kernel**: SDK for integrating AI Large Language Models

**R AI/ML Packages**:
- **torch**: Deep learning with R
- **tensorflow**: R interface to TensorFlow
- **caret**: Classification and regression training
- **mlr3**: Machine learning in R - next generation

**Production R Tools**:
- **RStudio Connect**: Publishing platform for R content
- **Shiny Server**: Server for hosting Shiny applications
- **R Package Manager**: Enterprise package management for R
- **RStudio Workbench**: Professional IDE and development environment

**Monitoring and Observability**:
- **OpenTelemetry**: Observability framework for cloud-native software
- **Jaeger**: Distributed tracing system
- **ELK Stack**: Elasticsearch, Logstash, and Kibana for log analysis
- **New Relic**: Application performance monitoring platform

## Action Items
- [ ] Set up development environment with required R packages and dependencies
- [ ] Practice basic agent creation using provided templates and examples
- [ ] Implement multi-agent workflow for a specific data science use case
- [ ] Develop evaluation framework for agent performance assessment
- [ ] Explore production deployment options for R-based agent systems
- [ ] Document lessons learned and best practices from workshop exercises

## Notes
- **Status**: Ready for workshop participation
- **Context**: Comprehensive hands-on workshop on R + LLM agent development
- **Expected Learning**: End-to-end agent development, evaluation, and deployment
- **Conference Position**: Final workshop session, Day 2
- **Duration**: 2 hours (3:00-5:00 PM)
- **Format**: Interactive workshop with practical exercises

---
*Created: 2025-11-13 | Conference: R+AI 2025*