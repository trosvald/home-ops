---
id: welcome
title: Welcome
---
This documentation accompanies my version controlled homelab where I self host many services which either better or worsen my life. I’ve had many iterations of my homelab and this site will document my encounters to help others own the road.

I'll try to documenting the full setup process from the very begining. I do this mainly for my own sake, so I can go back to find what I did easily. But also for others who might stumble on this while searching the big web for answers.

### What is Home Lab
*A homelab (in the context of IT) is a learning environment at home for IT equipment and systems that can be experimented with safely. This can provide useful experience with technology that you might not otherwise be able to get in your current role and can provide personal growth as well as allowing you to run personal projects at home or even as a hobby in its own right.*
*-- [Alex Gardner](https://alexgardner.id.au/homelab/)*

<!-- Having a compute and sometimes supporting networking setup in your personal space such as home, typically running 24x7 and hosting your needed workloads. This setup can be as small as having one or more [SBC](https://en.wikipedia.org/wiki/Single-board_computer), all the way up to multiple enterprise servers. You can choose setup based on your needs, budget, etc. -->

### Why
Its depend on your goals, for mine :
1. Learning purpose
2. Having a dedicated sand box to run and test your applications.
3. Data privacy.
4. Cutting cost on cloud services, etc.

<!-- ## Consideration -->
<!-- We have to keep our infrastructure constantly ‘up to date’… and yes, automate all the things, but still checking release notes, incompatible breaking changes, migrations, etc, which could lead to headaches and extra time consumption. -->
<!-- :::caution Maintenance
We have to keep our infrastructure constantly `up to date`, automate all the things, but still checking release notes, incompatible breaking changes, migrations, etc, which could lead to headaches and extra time consumption.
::: -->
<!-- ### Troubleshooting -->
<!-- There is always going to be issues, not only for the items mentiones above, but also because of the server(s) hardware, network, internet connection, etc. This is a project with complex moving parts, so we have to be prepared for it too. -->
:::caution Maintenance & Toubleshooting
Homelab is a project with complex moving parts, so we have to be prepared for it.
:::


<!-- ## How does your home operations work?
We use an open source and extensible continuous delivery system called [Flux](https://github.com/fluxcd/flux2). It’s actually called “Flux2”, but most of the community refers to it as “Flux”.

[Flux](https://github.com/fluxcd/flux2) is simply a tool that ensures that the Kubernetes cluster it is managing stays in sync with the configurations presenting in this repository.

We use other tools like [Renovate](https://github.com/renovatebot/renovate) to watch for dependency updates and automatically create new pull requests. When these pull requests are merged, [Flux](https://github.com/fluxcd/flux2) will automatically apply the changes to the cluster.


## Neat, How do I start my own?
Thanks to [onedr0p](https://github.com/onedr0p), there is a [cluster template](https://github.com/onedr0p/flux-cluster-template) that allows you to easily get started with your own kubernetes cluster at home. You don’t need to have multiple computers or a fancy setup to get one working.

If you’re interested, you can also join and talk with the community on discord : [Home Operations](https://discord.gg/home-operations). Several people are involved daily and it makes for some interesting conversations. -->

