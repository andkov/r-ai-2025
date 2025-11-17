# btw MCP Server Configuration Guide

## Overview

The btw MCP (Model Context Protocol) server has been configured to expose R tools to VS Code, enabling AI assistants to interact with your R environment directly.

## Configuration Summary

### ✅ What's Configured

1. **VS Code Settings** (`.vscode/settings.json`):
   - `r-btw` MCP server configured to run `btw::btw_mcp_server()`
   - `filesystem` MCP server for secure file access
   - Both servers use stdio transport protocol

2. **VS Code Tasks** (`.vscode/tasks.json`):
   - "Start btw MCP Server" - Launch btw MCP server in background
   - "Test btw MCP Tools" - Verify available tools and categories

3. **Available Tools**: 24 R tools through btw package:
   - **Environment tools (2)**: Data frame and environment inspection
   - **Documentation tools (1)**: R help system access  
   - **Git tools (7)**: Status, diff, log, commit, branch management
   - **File tools**: Text file read/write operations
   - **IDE tools**: Current editor content access
   - **Web tools**: URL content reading
   - **Session tools**: Package info and platform details
   - **Search tools**: CRAN package search capabilities

## Usage

### Starting the btw MCP Server

**Option 1: VS Code Task**
- Open Command Palette (`Ctrl+Shift+P`)
- Run: "Tasks: Run Task" → "Start btw MCP Server"

**Option 2: Terminal Command**
```r
library(btw)
btw_mcp_server()
```

**Option 3: R Script**
```bash
Rscript start-btw-mcp.R
```

### Testing MCP Tools

**VS Code Task**:
- Run: "Tasks: Run Task" → "Test btw MCP Tools"

**Manual Test**:
```r
library(btw)
length(btw_tools())  # Should show 24
btw_tools()          # List all available tools
```

## Expected Behavior

When properly configured:

1. **MCP Server Running**: Background process exposing R tools via stdio
2. **VS Code Integration**: AI assistant can access btw tools through MCP protocol
3. **R Environment Access**: AI can inspect data frames, get help, check git status
4. **Security**: Limited to configured directories and R session scope

## Troubleshooting

### Server Not Starting
- Verify btw package installed: `require("btw")`
- Check R version compatibility (built under R 4.5.2)
- Ensure no port conflicts if using HTTP transport

### VS Code Integration Issues  
- Restart VS Code to load MCP configuration
- Check VS Code developer console for MCP connection status
- Verify `.vscode/settings.json` syntax is valid

### Tool Access Problems
- Confirm MCP server process is running
- Test individual btw tools in R console first
- Check MCP transport protocol (stdio vs HTTP)

## Next Steps

1. **Test Integration**: Verify AI assistant can access btw tools
2. **Create Workflows**: Develop patterns for common R+MCP tasks  
3. **Document Usage**: Record successful integration examples
4. **Security Review**: Validate MCP access boundaries

---

**Files Created/Modified**:
- `.vscode/settings.json` - MCP server configuration
- `.vscode/tasks.json` - Added MCP management tasks  
- `start-btw-mcp.R` - Standalone server startup script

**Configuration Date**: 2025-11-14