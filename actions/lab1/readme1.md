Create a new repository on your own GitHub account and execute a Github Action workflow with the following details:

1. Repository Name - hello-world-repo
2. Work on the following branch - main
3. Workflow File Name - hello-world.yml
4. Workflow Name - Hello World
5. Trigger Workflow on push events
6. Workflow should have a Job named - hello-job
    a. Run Job on - ubuntu-latest runner
    b. Job has 1 step named - Echo text
    c. Run a command - echo "Hello, world!"
7. Trigger Workflow on push event should execute successfully