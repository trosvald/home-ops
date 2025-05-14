#!/bin/bash
find kubernetes/infra/talos/assets -type f | xargs -I{} sh -c "sed -i 's/$KUBERNETES_VERSION/{{ ENV.KUBERNETES_VERSION }}/g' {}"
find kubernetes/infra/talos/assets -type f | xargs -I{} sh -c "sed -i 's/$TALOS_VERSION/{{ ENV.TALOS_VERSION }}/g' {}"