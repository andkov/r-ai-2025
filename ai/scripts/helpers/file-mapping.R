# ============================================================================
# PORTABLE REPOSITORY FILE MAPPING TOOL
# ============================================================================
# Version: 1.0.0
# 
# STANDALONE UTILITY - No external dependencies
# Copy this file to any repository at ./ai/scripts/helpers/file-mapping.R
# and source it to get file mapping capabilities
#
# ============================================================================
# AI COPILOT INSTRUCTIONS FOR FILE MAPPING OPERATIONS
# ============================================================================
#
# 🤖 WHEN USER MENTIONS "FILE MAP" OR SIMILAR:
#
# TRIGGER PHRASES:
# - "file map", "show files", "list files", "repository structure"
# - "what files are here", "scan repository", "file inventory"
# - "show me all [extension] files", "find [type] files"
#
# IMMEDIATE RESPONSE PATTERN:
# 1. Source this file: source("ai/scripts/helpers/file-mapping.R")
# 2. Parse user intent for file extensions (see EXTENSION DETECTION below)
# 3. Call appropriate function based on user needs
# 4. Explain what you're doing as you execute
#
# EXTENSION DETECTION LOGIC:
# - If user mentions specific extensions: use those exactly
# - If user says "markdown" or "docs": use "md, qmd, Rmd"
# - If user says "code" or "scripts": use "R, py, js, css, html"
# - If user says "config" or "settings": use "yml, yaml, json, toml"
# - If user says "all files" or no extension: use "md" as safe default
# - If uncertain: ask user to clarify desired extensions
#
# FUNCTION SELECTION GUIDE:
# - map_repo_files(): Full tree view with statistics (default choice)
# - quick_file_scan(): When user wants simple list for single extension
# - smart_file_map(): When user provides natural language description
#
# EXAMPLE AI RESPONSES:
#
# User: "show me a file map"
# AI: "I'll generate a repository file map. Let me scan for markdown files first..."
#     source("ai/scripts/helpers/file-mapping.R")
#     map_repo_files()
#
# User: "what R files do we have"
# AI: "I'll scan for all R files in the repository..."
#     source("ai/scripts/helpers/file-mapping.R") 
#     quick_file_scan("R")
#
# User: "show me all documentation files"
# AI: "I'll map all documentation files (markdown, quarto, etc.)..."
#     source("ai/scripts/helpers/file-mapping.R")
#     map_repo_files("md, qmd, Rmd")
#
# User: "file map with python and R"
# AI: "Generating file map for Python and R files..."
#     source("ai/scripts/helpers/file-mapping.R")
#     map_repo_files("py, R")
#
# TROUBLESHOOTING FOR AI:
# - If function fails: check if file exists at expected path
# - If no files found: suggest user verify extensions or directory
# - If too many files: recommend more specific extensions
# - If user wants different format: explain available options
#
# POST-EXECUTION:
# - Summarize key findings (file counts, important directories)
# - Offer to drill down into specific directories if needed
# - Suggest related actions (like reading specific files)
#
# ============================================================================
# HUMAN USER USAGE EXAMPLES
# ============================================================================
#
# Basic Usage:
#   source("ai/scripts/helpers/file-mapping.R")
#   map_repo_files()                    # Default: .md files
#   map_repo_files("R, py, js")         # Multiple extensions
#   map_repo_files("qmd")               # Single extension
#   quick_file_scan(".R")               # Quick scan for R files
#
# Advanced Usage:
#   smart_file_map("show python files") # Natural language parsing
#   map_repo_files("yml, json", show_stats = FALSE) # No statistics
#   quick_file_scan("css")              # Fast scan for CSS files

# ============================================================================
# MAIN FUNCTION: Repository File Mapper
# ============================================================================

#' Map repository files with ASCII tree structure
#' 
#' 🤖 AI COPILOT: This is the PRIMARY function for file mapping requests.
#' Use this when users ask for "file map", "show files", "repository structure".
#' 
#' FUNCTION PURPOSE:
#' Scans repository for files matching specified extensions and displays
#' them in a console-friendly ASCII tree format. Completely self-contained
#' and portable across repositories.
#' 
#' AI USAGE PATTERNS:
#' - User says "file map" → map_repo_files() [default .md files]
#' - User says "show R files" → map_repo_files("R")  
#' - User says "all code files" → map_repo_files("R, py, js, css, html")
#' - User says "documentation" → map_repo_files("md, qmd, Rmd")
#' 
#' @param extensions Character. Comma-separated file extensions (default: "md")
#'                  Examples: "md", "R, py, js", "qmd, Rmd, md"
#'                  AI NOTE: Parse from user's natural language - see header guide
#' @param repo_root Character. Repository root path (default: auto-detect)
#'                  AI NOTE: Leave as NULL - auto-detection works reliably
#' @param show_stats Logical. Show file count statistics (default: TRUE)
#'                   AI NOTE: Keep TRUE unless user specifically wants minimal output
#' @param exclude_dirs Character vector. Directories to exclude from scan
#'                     AI NOTE: Default excludes node_modules, renv, etc. but includes .github/.vscode
#' 
#' @return Invisible list of found file paths
#' 
#' @examples
#' # AI Copilot Usage Examples:
#' map_repo_files()                    # User: "show file map" 
#' map_repo_files("R")                 # User: "what R files do we have"
#' map_repo_files("R, py, js")         # User: "show me all code files"
#' map_repo_files("md, qmd, Rmd")      # User: "list documentation files"
#' map_repo_files("yml, json")         # User: "show config files"
map_repo_files <- function(extensions = "md", 
                           repo_root = NULL,
                           show_stats = TRUE,
                           exclude_dirs = c("node_modules", "renv", "packrat", "__pycache__", ".Rproj.user")) {
  
  # Auto-detect repository root
  if (is.null(repo_root)) {
    repo_root <- find_repo_root()
  }
  
  # Parse file extensions from user input
  ext_list <- parse_file_extensions(extensions)
  
  # Header
  cat("\n")
  cat("=====================================\n")
  cat("📁 REPOSITORY FILE MAP\n") 
  cat("=====================================\n")
  cat("📂 Repository:", basename(normalizePath(repo_root)), "\n")
  cat("📄 Extensions:", paste(ext_list, collapse = ", "), "\n")
  cat("📍 Root Path:", repo_root, "\n")
  cat("\n")
  
  # Scan for files
  all_files <- scan_repository_files(repo_root, ext_list, exclude_dirs)
  
  if (length(all_files) == 0) {
    cat("❌ No files found matching extensions:", paste(ext_list, collapse = ", "), "\n")
    cat("💡 Try different extensions or check if files exist\n")
    return(invisible(character(0)))
  }
  
  # Generate and display ASCII tree
  tree_structure <- build_ascii_tree(all_files, repo_root)
  cat(paste(tree_structure, collapse = "\n"))
  cat("\n")
  
  # Statistics
  if (show_stats) {
    display_file_statistics(all_files, ext_list)
  }
  
  cat("\n")
  cat("✅ File mapping complete!\n")
  cat("📋 Use quick_file_scan() for faster single-extension scans\n")
  
  return(invisible(all_files))
}

# ============================================================================
# QUICK SCAN FUNCTION
# ============================================================================

#' Quick file scan for single extension
#' 
#' 🤖 AI COPILOT: Use this for FAST, SIMPLE file lists when user wants minimal output.
#' 
#' WHEN TO USE THIS FUNCTION:
#' - User asks for "quick scan", "list files", "simple list" 
#' - User wants ONE specific extension only
#' - User seems to want fast results without tree structure
#' - When map_repo_files() might be too verbose for user's needs
#' 
#' Fast, lightweight scan for a single file extension with minimal output.
#' Provides simple list format instead of tree structure.
#' 
#' @param extension Character. Single file extension (e.g., ".R", "md", "py")
#'                  AI NOTE: Accept with or without leading dot - function normalizes
#' @param repo_root Character. Repository root (default: auto-detect)
#'                  AI NOTE: Leave as NULL for auto-detection
#' 
#' @return Character vector of file paths (invisible)
#' 
#' @examples
#' # AI Copilot Usage Examples:
#' quick_file_scan(".R")       # User: "quickly list R files"
#' quick_file_scan("md")       # User: "simple list of markdown files" 
#' quick_file_scan("py")       # User: "show Python files, just the list"
#' quick_file_scan("yml")      # User: "any YAML files here?"
quick_file_scan <- function(extension, repo_root = NULL) {
  
  if (is.null(repo_root)) {
    repo_root <- find_repo_root()
  }
  
  # Normalize extension
  if (!startsWith(extension, ".")) {
    extension <- paste0(".", extension)
  }
  
  # Quick scan
  pattern <- paste0("\\", extension, "$")
  files <- list.files(repo_root, 
                     pattern = pattern, 
                     recursive = TRUE, 
                     full.names = FALSE)
  
  # Quick exclusions
  files <- files[!grepl("/(node_modules|renv|packrat|__pycache__|.Rproj.user)/", files)]
  
  if (length(files) == 0) {
    cat("❌ No", extension, "files found\n")
    return(invisible(character(0)))
  }
  
  # Simple output
  cat("📄", length(files), extension, "files found:\n")
  for (file in sort(files)) {
    cat("  ", file, "\n")
  }
  
  return(invisible(files))
}

# ============================================================================
# UTILITY FUNCTIONS (PORTABLE - NO EXTERNAL DEPENDENCIES)
# ============================================================================

#' Auto-detect repository root directory
#' 
#' 🤖 AI COPILOT: This function makes the tool PORTABLE across repositories.
#' You don't need to worry about paths - it finds the root automatically.
#' 
#' DETECTION STRATEGY:
#' Walks up directory tree looking for: .git, .github, config.yml, .Rproj, 
#' package.json, requirements.txt, etc. Works for R, Python, Node.js projects.
#' 
#' @param start_path Character. Starting directory (default: current working directory)
#'                   AI NOTE: Usually leave as default - auto-detection is reliable
#' @return Character. Repository root path
find_repo_root <- function(start_path = getwd()) {
  
  # Repository indicators (in order of preference)
  repo_indicators <- c(
    ".git",           # Git repository
    ".github",        # GitHub configuration
    "config.yml",     # Project configuration
    ".Rproj",         # R project (any .Rproj file)
    "package.json",   # Node.js project
    "requirements.txt", # Python project
    "Cargo.toml",     # Rust project
    "pom.xml"         # Maven project
  )
  
  current_path <- normalizePath(start_path)
  
  # Walk up directory tree
  while (current_path != dirname(current_path)) {  # Not at filesystem root
    
    # Check for repository indicators
    for (indicator in repo_indicators) {
      if (indicator == ".Rproj") {
        # Special case: look for any .Rproj file
        rproj_files <- list.files(current_path, pattern = "\\.Rproj$")
        if (length(rproj_files) > 0) {
          return(current_path)
        }
      } else {
        # Check for specific file/directory
        if (file.exists(file.path(current_path, indicator)) || 
            dir.exists(file.path(current_path, indicator))) {
          return(current_path)
        }
      }
    }
    
    # Move up one directory
    current_path <- dirname(current_path)
  }
  
  # Fallback to starting directory if no indicators found
  cat("⚠️  Repository root not detected, using:", start_path, "\n")
  return(start_path)
}

#' Parse file extensions from user input
#' 
#' 🤖 AI COPILOT: This handles messy user input gracefully.
#' 
#' INPUT FLEXIBILITY:
#' - "md" → [".md"]
#' - "R, py, js" → [".R", ".py", ".js"]  
#' - ".css, .html" → [".css", ".html"]
#' - "R,py,js" → [".R", ".py", ".js"] (no spaces needed)
#' 
#' Handles various input formats and normalizes to dot-prefixed extensions.
#' 
#' @param extensions Character. Extension string from user
#'                   AI NOTE: Pass user input directly - function cleans it up
#' @return Character vector of normalized extensions (with dots)
parse_file_extensions <- function(extensions) {
  
  if (is.null(extensions) || extensions == "") {
    return("md")  # Default
  }
  
  # Split on commas and clean
  ext_parts <- strsplit(as.character(extensions), "[,\\s]+")[[1]]
  ext_parts <- ext_parts[ext_parts != ""]  # Remove empty strings
  
  # Normalize extensions (ensure they start with dot)
  normalized <- sapply(ext_parts, function(ext) {
    ext <- trimws(ext)  # Remove whitespace
    if (startsWith(ext, ".")) {
      return(ext)
    } else {
      return(paste0(".", ext))
    }
  })
  
  return(as.character(normalized))
}

#' Scan repository for files matching extensions
#' 
#' Recursive file discovery with directory exclusions
#' 
#' @param repo_root Character. Repository root directory
#' @param extensions Character vector. File extensions to include
#' @param exclude_dirs Character vector. Directory patterns to exclude
#' @return Character vector of relative file paths
scan_repository_files <- function(repo_root, extensions, exclude_dirs) {
  
  # Build regex pattern for extensions
  ext_pattern <- paste0("(", paste(paste0("\\", extensions), collapse = "|"), ")$")
  
  # Get all files recursively
  all_files <- list.files(repo_root, 
                         pattern = ext_pattern, 
                         recursive = TRUE, 
                         full.names = FALSE)
  
  # Apply directory exclusions
  if (length(exclude_dirs) > 0) {
    exclude_pattern <- paste0("(^|/)(", paste(exclude_dirs, collapse = "|"), ")(/|$)")
    all_files <- all_files[!grepl(exclude_pattern, all_files)]
  }
  
  return(sort(all_files))
}

#' Build ASCII tree structure from file paths
#' 
#' Creates console-friendly tree representation using ASCII characters
#' 
#' @param file_paths Character vector. Relative file paths
#' @param repo_root Character. Repository root for display
#' @return Character vector of tree lines
build_ascii_tree <- function(file_paths, repo_root) {
  
  if (length(file_paths) == 0) {
    return(character(0))
  }
  
  # Start with repository root
  tree_lines <- paste0(basename(repo_root), "/")
  
  # Process each file path
  processed_dirs <- character(0)
  
  for (file_path in file_paths) {
    path_parts <- strsplit(file_path, "/")[[1]]
    
    # Build directory structure
    for (i in seq_along(path_parts)) {
      current_path <- paste(path_parts[1:i], collapse = "/")
      
      if (i < length(path_parts)) {
        # This is a directory
        if (!current_path %in% processed_dirs) {
          indent <- paste(rep("+-- ", i), collapse = "")
          tree_lines <- c(tree_lines, paste0(indent, path_parts[i], "/"))
          processed_dirs <- c(processed_dirs, current_path)
        }
      } else {
        # This is a file
        indent <- paste(rep("+-- ", i), collapse = "")
        tree_lines <- c(tree_lines, paste0(indent, path_parts[i]))
      }
    }
  }
  
  return(tree_lines)
}

#' Display file count statistics by extension
#' 
#' @param file_paths Character vector. File paths
#' @param extensions Character vector. Extensions searched for
display_file_statistics <- function(file_paths, extensions) {
  
  cat("📊 FILE STATISTICS\n")
  cat("=====================================\n")
  
  # Count by extension
  ext_counts <- table(sapply(file_paths, function(f) {
    parts <- strsplit(basename(f), "\\.")[[1]]
    if (length(parts) > 1) {
      return(paste0(".", parts[length(parts)]))
    } else {
      return("(no extension)")
    }
  }))
  
  # Display counts
  for (ext in names(ext_counts)) {
    cat(sprintf("  %-8s: %3d files\n", ext, ext_counts[ext]))
  }
  
  cat(sprintf("  %-8s: %3d files\n", "TOTAL", length(file_paths)))
}

# ============================================================================
# CHAT-FRIENDLY WRAPPER FUNCTION
# ============================================================================

#' Smart file mapping with natural language input parsing
#' 
#' 🤖 AI COPILOT: EXPERIMENTAL function for parsing natural language requests.
#' 
#' WHEN TO USE THIS FUNCTION:
#' - User provides verbose natural language description
#' - You're uncertain how to parse their extension request
#' - User says things like "show me python files" or "find config files"
#' - When you want automatic extension detection from user text
#' 
#' BUILT-IN PARSING PATTERNS:
#' - "python", "py files" → detects "py"
#' - "R files", "R scripts" → detects "R" 
#' - "markdown", "documentation" → detects "md"
#' - "config", "yaml" → detects "yml,yaml"
#' - "javascript", "js" → detects "js"
#' 
#' Wrapper function that tries to intelligently parse user requests
#' from chat context. Handles common variations of extension requests.
#' 
#' @param user_input Character. User's natural language input (optional)
#'                   AI NOTE: Pass the user's exact request text for parsing
#' @param ... Additional arguments passed to map_repo_files()
#' 
#' @return Same as map_repo_files()
#' 
#' @examples
#' # AI Copilot Usage Examples:
#' smart_file_map("show me all R files")      # User's exact words
#' smart_file_map("find python scripts")     # Natural language
#' smart_file_map("documentation files")     # Concept-based request
#' smart_file_map("config and yaml files")   # Multiple concepts
smart_file_map <- function(user_input = NULL, ...) {
  
  # Default to markdown if no input
  if (is.null(user_input) || user_input == "") {
    return(map_repo_files("md", ...))
  }
  
  # Convert to lowercase for parsing
  input_lower <- tolower(user_input)
  
  # Common extension mappings
  extension_patterns <- list(
    "r" = c("\\bR\\b", "r files", "r scripts"),
    "py" = c("python", "py files", "\\.py"),
    "js" = c("javascript", "js files", "\\.js"),
    "md" = c("markdown", "md files", "\\.md"),
    "qmd" = c("quarto", "qmd files", "\\.qmd"),
    "Rmd" = c("rmarkdown", "rmd files", "\\.rmd"),
    "css" = c("css files", "\\.css"),
    "html" = c("html files", "\\.html"),
    "json" = c("json files", "\\.json"),
    "yml,yaml" = c("yaml", "yml", "config")
  )
  
  # Try to detect extensions
  detected_extensions <- character(0)
  
  for (ext_key in names(extension_patterns)) {
    patterns <- extension_patterns[[ext_key]]
    
    for (pattern in patterns) {
      if (grepl(pattern, input_lower)) {
        detected_extensions <- c(detected_extensions, ext_key)
        break  # Found match for this extension, move to next
      }
    }
  }
  
  # Remove duplicates and use detected extensions
  if (length(detected_extensions) > 0) {
    extensions <- paste(unique(detected_extensions), collapse = ", ")
    cat("🤖 Detected extensions:", extensions, "\n")
  } else {
    # Fallback: try to extract anything that looks like an extension
    ext_matches <- regmatches(user_input, gregexpr("\\.[a-zA-Z0-9]+", user_input))[[1]]
    if (length(ext_matches) > 0) {
      extensions <- paste(ext_matches, collapse = ", ")
      cat("🤖 Found extensions:", extensions, "\n")
    } else {
      extensions <- "md"  # Ultimate fallback
      cat("🤖 No extensions detected, defaulting to: md\n")
    }
  }
  
  return(map_repo_files(extensions, ...))
}

# ============================================================================
# INITIALIZATION MESSAGE
# ============================================================================

# ============================================================================
# TOOL LOADED - READY FOR AI COPILOT OPERATIONS
# ============================================================================

cat("🗂️  Portable File Mapping Tool Loaded\n")
cat("🤖 AI COPILOT: Ready for file mapping operations\n")
cat("\n")
cat("📁 Available functions:\n")
cat("   map_repo_files()        - Full repository file mapping (PRIMARY)\n")
cat("   quick_file_scan()       - Fast single-extension scan (MINIMAL OUTPUT)\n") 
cat("   smart_file_map()        - AI-friendly natural language parsing (EXPERIMENTAL)\n")
cat("\n")
cat("💡 Human Examples:\n")
cat("   map_repo_files()              # All .md files\n")
cat("   map_repo_files('R, py')       # R and Python files\n")
cat("   quick_file_scan('.R')         # Quick R file scan\n")
cat("   smart_file_map('python files') # Natural language input\n")
cat("\n")
cat("🤖 AI TRIGGER PHRASES:\n")
cat("   'file map' → map_repo_files()\n")
cat("   'show R files' → map_repo_files('R') or quick_file_scan('R')\n") 
cat("   'list all code' → map_repo_files('R, py, js, css, html')\n")
cat("   'documentation files' → map_repo_files('md, qmd, Rmd')\n")
cat("   'config files' → map_repo_files('yml, yaml, json')\n")
cat("\n")
cat("📋 AI WORKFLOW:\n")
cat("   1. Parse user intent for file extensions\n")
cat("   2. Choose appropriate function (usually map_repo_files)\n")
cat("   3. Execute with detected extensions\n") 
cat("   4. Summarize key findings for user\n")
cat("\n")