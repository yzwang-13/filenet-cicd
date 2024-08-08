#!/bin/sh
cd manifests
yq eval-all '. as $item ireduce ({}; . *+ $item)' $(ls) > output.yaml
cat output.yaml