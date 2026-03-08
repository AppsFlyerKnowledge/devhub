---
title: "Integrate Android SDK with AI"
slug: "integrate-android-SDK-with-ai"
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
hidden: false
order: 0
---

Offload much of the AppsFlyer Android SDK integration work to AppsFlyer’s SDK MCP server by using an AI-powered coding tool, such as OpenAI Codex, Claude Code, or Cursor.

## Step 1: Get ready

- [Your **AppsFlyer Dev key**](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key)
- Your Android app project.
- Your AI-powered coding tool is installed and set up for your project
- Android Studio is installed to sync and run the app

## Step 2: Add the AppsFlyer SDK MCP server

To add the AppsFlyer SDK MCP server:

### Codex

1. In Codex, go to **Settings** > **MCP Servers**.
2. Click **+ Add server**.
3. In the **Name** box, give your server a name.
4. In **Command to launch,** enter  `npx`.
5. In **Arguments,** enter the following arguments, each in a different field:
    - `-y` (to install and update your MCP each run).
    - `@appsflyer/sdk-mcp-server` (the server name as listed on the NPM registry).
6. In the **Environment variables**, add: the variables  `DEV_KEY` and APP_ID, and their values.
7. Restart Codex to load the new **MCP server**.
8. In Codex, open **Settings** > **MCP Servers** and confirm that the A**ppsFlyer SDK MCP server** is turned on.

### Cursor

1. In Cursor, go to **Cursor** > **Settings…** > **Cursor settings** > **Tools & MCP**.
2. Click **New MCP server**.
3. Add a new MCP server entry in **mcp.json**:
    
    ```json
    "appsFlyer-sdk-mcp": {
            "command": "npx",
            "args": [
              "-y",
              "@appsflyer/sdk-mcp-server"
            ],
            "env": {
              "APP_ID": "com.appsflyer.onelink.appsflyeronelinkbasicapp",
              "DEV_KEY": "sQ84wpdxRTR4RMCaE9YqS4"
            }
    },
    ```
    
4. Restart Cursor to apply the changes.
5. In Cursor, go to **Cursor** > **Settings…** > **Cursor settings** > **Tools & MCP**.
6. Find the MCP server entry you added.
7. Confirm it’s marked with a **green dot**. This indicates the MCP server is working.

### GitHub Co-pilot

1. In Android Studio, open **Settings** and go to **Tools** > **GitHub Copilot>  Model Context Protocol (MCP).**
2. Click **Configure**.
3. In **mcp.json,** add the AppsFlyer SDK MCP server settings: 
    
    ```json
    "appsFlyer-sdk-mcp": {
            "command": "npx",
            "args": [
              "-y",
              "@appsflyer/sdk-mcp-server"
            ],
            "env": {
              "APP_ID": "com.appsflyer.onelink.appsflyeronelinkbasicapp",
              "DEV_KEY": "sQ84wpdxRTR4RMCaE9YqS4"
            }
          },
    ```
    
4. Restart Android Studio to apply the changes.
5. In Android Studio, open the GitHub Copilot Chat. 
6. At the bottom of the Copilot Chat panel, select **Agent** from the agents dropdown.
7. Click the displayed MCP Tools button.
8. In the **Configure Tools** dialog, for the **appsFlyer-sdk-mcp** tool, click **Start.**
9. To confirm that the server is running, in the left sidebar, click the GitHub Copilot **MCP Log** button. In the displayed MCP log panel,  you should see that the server is running.  

## Step 3: Prompt the AI to integrate the SDK

1. In the chat, type **Integrate the AppsFlyer SDK using MCP**.
2. Review the changes in your codebase in your editor, and verify that the integrated code matches your project requirements and coding standards. If anything looks unfamiliar, ask the AI follow-up questions.

## Step 4: Prompt AI to verify the integration

1. Open **Android Studio**.
2. Sync the project.
3. Run your app.
4. In the chat, prompt to verify the AppsFlyer SDK integration. The AI agent will use the MCP tool to read logs from your device and confirm whether the integration succeeded.
    - If errors are detected, the tool will explain what went wrong and suggest fixes.
    - If everything looks good, you’ll see confirmation of a successful integration.