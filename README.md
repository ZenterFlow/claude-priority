# Claude Priority Skills

Priority skills and tools for immediate integration into projects.

## Purpose

This repository contains high-priority, ready-to-use skills that are awaiting review or immediate deployment. Skills here are typically:
- Newly created and testing-ready
- Pending integration into main repositories
- Quick prototypes for validation

## Contents

### plugin-formatter
**Description**: Formats plugin folders and files according to Claude Code plugin marketplace guidelines

**Key Features**:
- Validates plugin.json, marketplace.json against schemas
- Converts naming to lowercase-with-hyphens
- Auto-fixes string-to-object conversions (author/owner fields)
- Regenerates README.md skill lists
- Creates missing template files

**Files**:
- `skill.md` - Main skill documentation
- `rules.md` - Formatting rules
- `templates/` - Plugin, skill, README, manifest templates
- `schemas/` - JSON schemas for validation

**Status**: ✅ Ready for use

## Usage

Copy skills from this repo into your project's `.claude/skills/` directory or link to the claude-code-global repository for permanent access.

## Workflow

1. Skills created here for rapid prototyping
2. Test and validate in actual projects
3. Promote successful skills to claude-code-global
4. Remove from priority repo once integrated

## Version
v1.0.0 (2025-11-01)
