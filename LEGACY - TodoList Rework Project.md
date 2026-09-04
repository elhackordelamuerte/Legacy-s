## TodoList to Kanban Application Rework Agile Project

## 1. Project context

You are joining an existing software project that has accumulated technical debt over time.

Your team will be responsible for analysing the existing codebase, identifying its main limitations, and progressively transforming it into a maintainable, scalable and production-ready application.

The objective is not simply to add features. You are expected to improve the overall quality of the application while delivering new functionality.

You will work on this project : https://github.com/docker/getting-started-app [URL 🔗](https://github.com/docker/getting-started-app)

## 2. Starting point

You will be provided with an existing GitHub repository.

The current application presents several technical and architectural limitations.

Your first task is therefore to understand the existing system before deciding how it should evolve.

You should pay particular attention to:

- the current application structure;

- the frontend and backend organisation;

- the way responsibilities are currently distributed;

- the existing testing strategy;

- the current level of typing and code quality;

- the way the application is built and deployed.

You are

Your solution should demonstrate that you are able to identify technical debt and make appropriate architectural decisions.

not expected to keep the existing architecture as it is.

## 3.Main objective

Your goal is to transform the existing TodoList application into a clean, maintainable and evolvable project.

The final solution should provide:

- a functional user interface;

- secure user authentication;

- project and task management;

- task organisation through a Kanban-style workflow;


- priorities and deadlines;

- appropriate user notifications;

- automated quality checks;

- a reliable CI/CD process;

- communication between relevant parts of the system through an event-driven approach.

The exact technical implementation is deliberately left to you.

You will need to justify the architectural and technical choices made by your team.

## 4. Architecture & technical expectations

The application should evolve towards a properly structured and scalable architecture.

You are expected to think about:

- separation of responsibilities;

- communication between application components;

- API design;

- authentication and security;

- asynchronous communication where appropriate;

- data ownership;

- testability;

- maintainability;

deployment and automation.

The system should include an event-driven mechanism allowing components to communicate through events.

At least one complete and demonstrable event-driven workflow is expected.

The architecture should be operational end-to-end early in the project rather than being postponed until the final sprint.

## 5. Agile organization

The project will be managed using Scrum practices.

Each team must define and maintain a product backlog and work from clearly prioritised user stories.

## 5.1. Roles

Each team should identify:

- a Product Owner representative;

- a Scrum Master, rotating between team members throughout the project.

## 5.2. Ceremonies

You are expected to organise:


- Daily stand-ups;

- Sprint Planning;

- Sprint Reviews;

- Retrospectives.

Your Agile process is part of the project deliverable.

The board, backlog, Git history and other relevant traces should demonstrate how your team worked throughout the project.

## 6. Prioritisation

You will use the MoSCoW prioritisation method.

You should not attempt to implement everything at once.

The priority should be to deliver a small, coherent and high-quality product rather than a large number of incomplete features.

## 6.1. Must have

The final solution must provide, at minimum:

- secure authentication;

- GDPR-compatible user management;

- project and task CRUD operations;

- a basic Kanban workflow;

- a complete CI pipeline;

- Docker image publication;

- at least one demonstrable event-driven workflow.

## 6.2. Should have

If the core scope is under control, you should work towards:

- notifications;

- task priorities and deadlines;

- a personalised home screen;

- a blocking code-quality gate.

## 6.3. Could have

These features may be implemented if the team has sufficient time:

- automatic project closure;

- a complete Continuous Delivery process;

- contract testing between components/services.

## 6.4. Would have

Features outside the defined scope should not be improvised simply to increase the number of features. They should instead be documented as potential future work.


## 7. Definition of Done

A User Story is considered Done only when all relevant quality requirements have been met.

A completed User Story should:

- 1. Be reviewed through a Pull Request with at least one approval.

- 2. Include appropriate unit tests for the business logic introduced.

- 3. Meet the required code coverage level.

- 4. Pass the project’s code-quality gate.

- 5. Pass the complete CI pipeline.

- 6. Produce the required build artifacts/Docker image.

- 7. Have its associated documentation updated.

- 8. Be demonstrated during a Sprint Review.

A feature that works locally but does not satisfy these requirements should not be considered Done.

## 8. Sprint objectives

## 8.1. Sprint 1 – Foundation & Architecture

Your objective is to:

- understand the existing application;

- turn the requirements into a usable backlog;

- establish your development conventions;

- define and implement your target architecture;

- establish a working end-to-end application flow;

- introduce the foundations of your event-driven architecture;

- establish the CI and quality processes.

By the end of Sprint 1, your team should already be able to demonstrate a coherent technical foundation.

## 8.2. Sprint 2 – Core Features

Focus on delivering the main functional requirements.

The quality process should now be fully integrated into your development workflow.

Features should be delivered incrementally through short Pull Requests rather than through one large final integration.

## 8.3. Sprint 3 – Stabilisation & Quality

The final sprint should focus on:

- stabilisation;

- testing;

- code quality;

- fixing technical debt;

- completing high-priority features;

- optional features where justified;

- deployment;

- preparing the final demonstration;

- ensuring that the Git history accurately reflects the team-s work.

## 9. Assessment

Your project will be assessed not only on the number of features delivered, but also on the quality of the solution and the way you worked as a team.

The following aspects will be considered:

## Intermediate Review

- Architecture and technical foundations;

- CI pipeline;

- Event-driven workflow;

- Quality and prioritisation of the backlog;

- Git conventions;

- Code-quality gate;

- Demonstration of a typical User Story workflow.

## Final Review

- Functional coverage according to priorities;

- Code quality and test coverage;

- CI/CD;

- Git history and Pull Request practices;

- Agile organisation and team retrospective;

- Overall quality and maintainability of the solution.

## 10. Important guidelines

Keep the following principles in mind throughout the project:

## Quality over quantity.

Do not spread your effort across too many User Stories at the same time.

## Build the foundations early.

Your architecture, CI pipeline, quality checks and event-driven communication should not be left until the end of the project.

## Deliver frequently.

Prefer small, focused Pull Requests and incremental deliveries.

## Make your decisions explicit.

When making an important technical or architectural decision, be prepared to explain and justify it.


## Keep evidence of your work.

Your Git history, Pull Requests, backlog, board, documentation and Sprint Reviews should provide a clear picture of how the project evolved.

The objective is not to produce the largest application possible.

The objective is to demonstrate that your team can take an existing codebase, understand it,

improve it, structure it and make it evolve using professional software engineering practices.
