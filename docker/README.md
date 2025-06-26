[What is Docker](https://docs.docker.com/get-started/overview/)

[What is container](https://www.docker.com/resources/what-container/)

[What is Microservice](https://aws.amazon.com/microservices/)

#######################################################################
Monolithic Architecture
A monolithic application is built as a single unified unit.

Characteristics:
All functionalities (UI, business logic, database access, etc.) are packaged and deployed together.

Typically has one codebase and is deployed as one WAR, JAR, or EXE file.

Any update requires the entire application to be rebuilt and redeployed.

Pros:
1)Simple to develop initially.

2)Easier to test and debug locally.

3)Fewer cross-service concerns (like network latency, inter-service communication).

Cons:
1)Becomes difficult to maintain as codebase grows.

2)Hard to scale individual parts — must scale the whole app.

3)Longer deployment times.

4)Tight coupling between components makes changes risky.

########################################################################

Microservices Architecture
A microservices application is split into multiple small, independent services — each responsible for a specific feature or functionality.

Characteristics:
Each service has its own codebase, database, and deployment pipeline.

Services communicate over network protocols like REST, gRPC, or message queues (e.g., RabbitMQ, Kafka).

Often managed using tools like Docker, Kubernetes, Consul, etc.

Pros:
1)Services can be developed, deployed, and scaled independently.

2)Teams can work autonomously on different services.

3)Better fault isolation — if one service fails, others may still work.

4)Easier to adopt new technologies per service.

Cons:
1)More complex infrastructure (requires DevOps tools, monitoring, API gateways).

2)Requires careful handling of inter-service communication and consistency.

3)Testing is more complex (end-to-end vs unit testing).

4)Higher latency due to network calls between services.

#######################################################################

| Feature               | Monolithic                            | Microservices                           |
| --------------------- | ------------------------------------- | --------------------------------------- |
| **Architecture**      | Single codebase/application           | Multiple independent services           |
| **Deployment**        | One unit                              | Each service deploys independently      |
| **Scalability**       | Entire app scaled together            | Each service can scale individually     |
| **Development Speed** | Fast at first, slows as app grows     | Can be faster with distributed teams    |
| **Tech Stack**        | Uniform across app                    | Can vary per service                    |
| **Failure Isolation** | One part failing may affect the whole | Failure is isolated to individual svc   |
| **DevOps Complexity** | Simple                                | Requires orchestration tools (e.g. K8s) |
| **Database**          | Shared                                | Often one per service (DB per svc)      |

########################################################################

Example:
Monolithic: A single Java app that handles login, product catalog, cart, and checkout — all in one deployable WAR file.

Microservices: Separate services for login (Java), catalog (Node.js), cart (Python), checkout (Go), all deployed in containers.
