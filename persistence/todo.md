# Two-Repository Migration Tasks

## Pre-Migration
- [x] Verify current state and run tests (All tests passing ✅)
- [x] Create timestamped backup (claude-priority-backup-TIMESTAMP created ✅)
- [x] Document current state (233 files, 1011K ✅)

## Phase 1: Create Development Repository
- [x] Create claude-priority-dev repository on GitHub ✅
- [x] Clone current repo as dev repo locally ✅
- [x] Update dev repo README with developer focus ✅
- [x] Initial commit and push dev repo (f317e12) ✅

## Phase 2: Configure Sync Workflow
- [x] Create GitHub Personal Access Token ✅
- [x] Add token as secret to dev repo (PRODUCTION_SYNC_TOKEN) ✅
- [x] Create sync workflow in dev repo (sync-to-production.yml) ✅

## Phase 3: Clean Production Repository
- [x] Remove development content (example-plugin, tests, .githooks) ✅
- [x] Clean up documentation ✅
- [x] Update marketplace.json to remove example-plugin ✅
- [x] Simplify CI/CD workflows ✅
- [x] Create user-focused README ✅
- [ ] Push production changes

## Phase 4: Verification
- [ ] Verify production repository structure and size
- [ ] Verify dev repository and run tests
- [ ] Test production marketplace installation
- [ ] Test sync workflow

## Phase 5: Finalization
- [ ] Update CHANGELOG in both repos
- [ ] Create GitHub releases

---
**Status**: In Progress - Phase 3 (Almost Complete)
**Current Task**: Commit and push production changes
**Pre-Migration**: Complete ✅
**Phase 1**: Complete ✅ (Dev repo created at f317e12)
**Phase 2**: Complete ✅ (Sync workflow added at 9e04ce4)
**Phase 3**: Production cleanup complete, ready to commit ✅
