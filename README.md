# Azure 3-Tier Enterprise Architecture using Terraform

```
                                 ┌────────────────────────────┐
                                 │      INTERNET USERS        │
                                 └───────────────▲────────────┘
                                                 │
                                          HTTPS / HTTP
                                                 │
                                 ┌───────────────▼───────────────┐
                                 │    Application Gateway (WAF)  │
                                 │  Public Entry + Routing Layer │
                                 └───────────────▲───────────────┘
                                                 │
                    ┌────────────────────────────┼────────────────────────────┐
                    │                            │                            │
                    ▼                            ▼                            ▼
┌──────────────────────────┐        ┌──────────────────────────┐        ┌──────────────────────────┐
│  Management Subnet       │        │   Web Tier Subnet        │        │  Business Tier Subnet    │
│  Jumpbox (SSH/RDP entry) │◀──────▶│  Web LB (Private)        │◀──────▶│  Biz LB (Private)        │
└──────────────────────────┘        │  VM1 + VM2               │        │  VM1 + VM2               │
                                    └──────────────────────────┘        └──────────────────────────┘
                                                             │
                                                             ▼
                                               ┌──────────────────────────────┐
                                               │        Data Subnet           │
                                               │    SQL VMs + Quorum Disk     │
                                               └───────────────▲──────────────┘
                                                               │
                                                   ┌───────────┴───────────┐
                                                   │ Cloud Witness Storage │
                                                   └───────────────────────┘
```

---

## What This Deploys

| Layer       | Components                                       |
| ----------- | ------------------------------------------------ |
| Networking  | VNet + Subnets (AppGW, Mgmt, Web, Biz, Data, AD) |
| Security    | NSG rules isolating lateral movement             |
| Entry Point | Application Gateway (WAF_v2)                     |
| Access      | Jumpbox (only public reachable VM)               |
| Web Tier    | 2× Linux VMs + private Load Balancer             |
| Biz Tier    | 2× Linux VMs + private Load Balancer             |
| Data Tier   | SQL VMs + Cloud Witness storage                  |
| IaC         | 100% Terraform modular deployment                |

---

## Deployment

```
terraform init
terraform plan
terraform apply
```

> Jumpbox → private hop → web/biz/data tier  
> App Gateway is **only external endpoint**

---

## Interview-Ready Key Lines (Use These Exactly)

### Tell the interviewer in 15 seconds:

> I deployed a complete 3-tier Azure infrastructure using Terraform —  
> WAF-enabled App Gateway as ingress, private load balancers for Web & Biz tiers,  
> Jumpbox-only admin access, SQL isolated in data subnet with cloud witness.

### Why 3 tier?

> Separation of presentation, logic and data = security + scalability.

### Why Jumpbox?

> No public exposure of backend VMs — one controlled admin entry.

### Why App Gateway instead of LB?

> WAF + SSL termination + better routing + edge security at one entry point.

### Why internal load balancers?

> Web/Biz/Data remain private — only east-west traffic allowed.

---

## Resume Bullet Points

```
• Built Azure 3-tier architecture using Terraform modules
• Implemented WAF_v2 App Gateway with private Web/Biz tiers
• Jumpbox-based secure access, no public exposure for workloads
• NSGs, routing control, internal LBs, and SQL data isolation
• Production-style infra, scalable & modular configuration
```

---
