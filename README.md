# E-Shop Project - CI/CD Workflow
## Branches: main (Prod), test (QA), develop (Dev)

## Since we set develop as the default branch and locked main and test, the team should follow this cycle:
Sync: git checkout develop and git pull origin develop.
Branch: Create a new branch for the task: git checkout -b feature/ui-login.
Work: Write code, git add ., and git commit -m "feat: implement login screen".
Push: git push origin feature/ui-login.
Review: Open a Pull Request (PR) on GitHub from feature/ui-login into develop.
