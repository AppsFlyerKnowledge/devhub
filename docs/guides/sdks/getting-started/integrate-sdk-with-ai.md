---
title: Integrate SDK with AI
slug: integrate-sdk-with-ai
category:
  uri: AppsFlyer SDKs
parent:
  uri: getting-started
privacy:
  view: public
position: 1
---

Offload much of the AppsFlyer SDK integration work to AppsFlyer's SDK MCP server by using an AI-powered coding tool, such as OpenAI Codex, GitHub Copilot, or Cursor. This guide applies to both **iOS** and **Android** app projects.

## Step 1: Get ready

- Your [**AppsFlyer Dev key**](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key).
- Your app project (iOS or Android).
- Your app identifier:
  - **Android**: your app's package name (for example, `com.example.myapp`).
  - **iOS**: your app's bundle ID or App Store ID (for example, `id123456789`).
- Your AI-powered coding tool is installed and set up for your project.
- Your IDE is installed to sync, build, and run the app:
  - **Android**: Android Studio.
  - **iOS**: Xcode.

## Step 2: Add the AppsFlyer SDK MCP server

The AppsFlyer SDK MCP server is the same for both platforms. The only values that change are your `DEV_KEY` and `APP_ID` environment variables. Choose the instructions for your AI coding tool below.

### Cursor

1. In Cursor, go to **Cursor** > **Settings…** > **Cursor settings** > **Tools & MCP**.

2. Click **New MCP server**.

3. Add a new MCP server entry in **mcp.json**, using your own app's `APP_ID` and `DEV_KEY`:

   ```json
   "appsFlyer-sdk-mcp": {
     "command": "npx",
     "args": [
       "-y",
       "@appsflyer/sdk-mcp-server"
     ],
     "env": {
       "APP_ID": "<your-app-identifier>",
       "DEV_KEY": "<your-dev-key>"
     }
   }
   ```

4. Restart Cursor to apply the changes.

5. In Cursor, go to **Cursor** > **Settings…** > **Cursor settings** > **Tools & MCP**.

6. Find the MCP server entry you added.

7. Confirm it's marked with a **green dot**. This indicates the MCP server is working.

### Claude Code

1. In your project terminal, run the following Claude Code command, using your own app's `APP_ID` and `DEV_KEY`:

   ```bash
   claude mcp add --transport stdio appsFlyer-sdk-mcp \
     -e APP_ID=<your-app-identifier> \
     -e DEV_KEY=<your-dev-key> \
     -- npx -y @appsflyer/sdk-mcp-server
   ```

2. Restart Claude Code to load the new server.

3. Confirm that **appsFlyer-sdk-mcp** is listed and connected (run `claude mcp list`).

### Codex

1. In Codex, go to **Settings** > **MCP Servers**.
2. Click **+ Add server**.
3. In the **Name** box, give your server a name.
4. In **Command to launch**, enter `npx`.
5. In **Arguments**, enter the following arguments, each in a different field:
   - `-y` (to install and update your MCP each run).
   - `@appsflyer/sdk-mcp-server` (the server name as listed on the NPM registry).
6. In **Environment variables**, add the variables `DEV_KEY` and `APP_ID`, and their values for your app.
7. Restart Codex to load the new **MCP server**.
8. In Codex, open **Settings** > **MCP Servers** and confirm that the **AppsFlyer SDK MCP server** is turned on.

### GitHub Copilot (Android only)

> **Note:** These GitHub Copilot steps apply to **Android** projects in Android Studio. For iOS, use **Codex** or **Cursor** above.

1. In Android Studio, open **Settings** and go to **Tools** > **GitHub Copilot** > **Model Context Protocol (MCP)**.

2. In the **Model Context Protocol (MCP)** settings, click **Configure**.

3. In **mcp.json**, add the AppsFlyer SDK MCP server settings, using your own app's `APP_ID` and `DEV_KEY`:

   ```json
   "appsFlyer-sdk-mcp": {
     "command": "npx",
     "args": [
       "-y",
       "@appsflyer/sdk-mcp-server"
     ],
     "env": {
       "APP_ID": "<your-app-identifier>",
       "DEV_KEY": "<your-dev-key>"
     }
   }
   ```

4. Restart Android Studio to apply the changes.

5. In Android Studio, open the **GitHub Copilot Chat**.

6. At the bottom of the Copilot Chat panel, select **Agent** from the agents dropdown.

7. Click the **MCP Tools** button.

8. In the **Configure Tools** dialog, for the **appsFlyer-sdk-mcp** tool, click **Start**.

9. To confirm that the server is running, open the GitHub Copilot **MCP Log**. In the displayed MCP log panel, you should see that the server is running.

## Step 3: Prompt the AI to integrate the SDK

1. In the chat, type **Integrate the AppsFlyer SDK using MCP**.
2. Review the changes in your codebase in your editor, and verify that the integrated code matches your project requirements and coding standards. If anything looks unfamiliar, ask the AI follow-up questions.

## Step 4: Prompt the AI to verify the integration

1. Open your IDE (Android Studio for Android, Xcode for iOS).
2. Sync the project.
3. Build and run your app.
4. In the chat, prompt the AI to verify the AppsFlyer SDK integration. The AI agent will use the MCP tool to read logs from your device and confirm whether the integration succeeded.
   - If errors are detected, the tool will explain what went wrong and suggest fixes.
   - If everything looks good, you'll see confirmation of a successful integration.
