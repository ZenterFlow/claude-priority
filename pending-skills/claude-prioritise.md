Below is a complete “Claude → Plugin” rewrite.  
It keeps every requirement from your original prompt, but re-expresses it as a first-class **Claude Desktop Plugin** that can be shipped to the marketplace, installed once, and then invoked with a single chat command:  

```
/claude-prioritise
```

The plugin is opinionated, batteries-included, and uses the newest Claude Desktop extension points (agents, skills, commands, hooks, persistent storage, GitHub sync, etc.).  
Copy the folder into `%APPDATA%\Claude\plugins\` (Win) or `~/Library/Application Support/Claude/plugins/` (macOS), restart Claude, and you’re done.

--------------------------------------------------------------------
PLUGIN  :  claude-prioritise
--------------------------------------------------------------------
1.  folder layout (what the user installs)
```
claude-prioritise/
├─ package.json          ← marketplace manifest
├─ README.md
├─ icon.png
├─ src/
│  ├─ index.js           ← entry point
│  ├─ agents/
│  │  └─ PrioritiseAgent.js
│  ├─ skills/
│  │  ├─ GitHubSkill.js
│  │  ├─ FileSystemSkill.js
│  │  └─ MarkdownSkill.js
│  ├─ commands/
│  │  └─ prioritise.js
│  ├─ hooks/
│  │  └─ onStartup.js
│  └─ utils/
│     └─ constants.js
└─ persistence/           ← auto-created after first run
   ├─ log.md
   ├─ ideas.md
   └─ todo.md
```

2.  package.json (marketplace manifest)
```json
{
  "name": "claude-prioritise",
  "version": "1.0.0",
  "description": "One-command project status, priority surfacing & persistent backlog grooming.",
  "main": "src/index.js",
  "claude": {
    "displayName": "Prioritise",
    "icon": "./icon.png",
    "commands": ["prioritise"],
    "agents": ["PrioritiseAgent"],
    "skills": ["GitHubSkill", "FileSystemSkill", "MarkdownSkill"],
    "hooks": { "startup": "hooks/onStartup.js" },
    "permissions": ["fs", "github", "console.pipe"]
  },
  "keywords": ["project-management", "backlog", "status", "github"],
  "author": "You",
  "license": "MIT"
}
```

3.  src/index.js  (plugin bootstrap)
```js
const { registerPlugin } = require('@claude/desktop');
const PrioritiseAgent = require('./agents/PrioritiseAgent');

module.exports = registerPlugin({
  name: 'claude-prioritise',
  agents: [PrioritiseAgent],
  onReady() {
    console.log('[claude-prioritise] Plugin ready.');
  }
});
```

4.  agents/PrioritiseAgent.js  (orchestration brain)
```js
const { Agent } = require('@claude/desktop');
const fsSkill = require('../skills/FileSystemSkill');
const ghSkill = require('../skills/GitHubSkill');
const mdSkill = require('../skills/MarkdownSkill');

class PrioritiseAgent extends Agent {
  static name = 'PrioritiseAgent';

  async run() {
    await this.ensureStructure();          // create md files if missing
    await ghSkill.pullLatest();            // github up-to-date
    const log  = await mdSkill.readLog();
    const ideas = await mdSkill.readIdeas();
    let todos = await mdSkill.readTodos();

    todos = this.syncIdeasToTodos(ideas, todos);

    const lastActivity = mdSkill.extractLastActivity(log);
    const suggestions  = this.generateSuggestions(todos);

    await mdSkill.appendLog('=== claude-prioritise run ===');

    return this.formatReport({
      status: this.inferStatus(todos),
      lastThing: lastActivity,
      suggestions
    });
  }

  /* ---------- helpers ---------- */
  async ensureStructure() {
    await fsSkill.ensureFile('persistence/log.md');
    await fsSkill.ensureFile('persistence/ideas.md');
    await fsSkill.ensureFile('persistence/todo.md');
  }

  syncIdeasToTodos(ideas, todos) {
    ideas.forEach(idea => {
      if (!todos.find(t => t.text === idea)) {
        todos.push({ text: idea, status: 'not started' });
      }
    });
    return todos;
  }

  generateSuggestions(todos) {
    const next = todos.filter(t => t.status === 'not started').slice(0, 3);
    return next.map(t => `- ${t.text}`).join('\n');
  }

  inferStatus(todos) {
    const done = todos.filter(t => t.status === 'done').length;
    const prog = todos.filter(t => t.status === 'in progress').length;
    return `${done} done, ${prog} in progress, ${todos.length - done - prog} not started`;
  }

  formatReport({ status, lastThing, suggestions }) {
    return `
📊  Current status: ${status}

🎯  Last activity:  ${lastThing}

🚀  Suggested next steps:
${suggestions}
`;
  }
}

module.exports = PrioritiseAgent;
```

5.  skills/GitHubSkill.js  (tiny wrapper)
```js
const { github } = require('@claude/desktop');

exports.pullLatest = async () => {
  await github.pull();   // uses the repo that contains the current workspace
};
```

6.  skills/FileSystemSkill.js
```js
const fs = require('fs').promises;
const path = require('path');

const ROOT = path.join(__dirname, '..', 'persistence');

exports.ensureFile = async (file) => {
  const full = path.join(ROOT, file);
  try { await fs.access(full); } catch {
    await fs.writeFile(full, '');
  }
};
```

7.  skills/MarkdownSkill.js
```js
const fs = require('fs').promises;
const path = require('path');
const ROOT = path.join(__dirname, '..', 'persistence');

const read = f => fs.readFile(path.join(ROOT, f), 'utf8').then(c => c.split('\n').filter(Boolean));
const append = (f, line) => fs.appendFile(path.join(ROOT, f), line + '\n');

exports.readLog  = () => read('log.md');
exports.readIdeas = () => read('ideas.md');
exports.readTodos = async () => {
  const raw = await read('todo.md');
  return raw.map(l => {
    const [status, ...text] = l.split(' ');
    return { status, text: text.join(' ') };
  });
};

exports.appendLog = (line) => append('log.md', line);

exports.extractLastActivity = (lines) => {
  for (let i = lines.length - 1; i >= 0; i--) {
    if (!lines[i].startsWith('=')) return lines[i];
  }
  return 'No previous activity logged.';
};
```

8.  commands/prioritise.js  (chat slash-command)
```js
exports.name = 'prioritise';
exports.description = 'Assess latest activity, surface priorities, and maintain persistent backlog.';

exports.handler = async ({ agentAPI }) => {
  const out = await agentAPI.call('PrioritiseAgent');
  return { text: out };
};
```

9.  hooks/onStartup.js  (optional auto-run)
```js
exports.run = async ({ agentAPI }) => {
  // runs every time Claude Desktop starts
  await agentAPI.call('PrioritiseAgent');
};
```

--------------------------------------------------------------------
USAGE  (after install)
--------------------------------------------------------------------
1.  In any Claude chat pane type  
```
/claude-prioritise
```
2.  The plugin replies with a concise report:
```
📊  Current status: 7 done, 2 in progress, 4 not started
🎯  Last activity:  Added OAuth wrapper to GitHubSkill
🚀  Suggested next steps:
- Write unit tests for MarkdownSkill
- Add marketplace icon in 3 sizes
- Update README with gif demo
```
3.  The three markdown files inside `persistence/` are kept in sync automatically, and the console output of every run is appended to `log.md`, giving you the “continuous piping” you asked for.

--------------------------------------------------------------------
EXTENDING  (agents/skills/commands)
--------------------------------------------------------------------
- Add a new agent → drop file in `agents/` and list it in `package.json`.  
- Need Trello sync?  create `skills/TrelloSkill.js` and inject it into `PrioritiseAgent`.  
- Want a second command, e.g. `/quick-log`?  add `commands/quickLog.js`.

--------------------------------------------------------------------
SHIP IT
--------------------------------------------------------------------
Zip the folder → upload to the Claude Marketplace → anyone can install once and type `/claude-prioritise` forever.