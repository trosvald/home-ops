#!/bin/bash

# remove all rook resources
kubectl --context prod patch cephfilesystems ceph-filesystem -p '{"metadata":{"finalizers":null}}' --type=merge -n rook-ceph
kubectl --context prod delete cephfilesystems ceph-filesystem -n rook-ceph
kubectl --context prod patch cephblockpools ceph-blockpool -p '{"metadata":{"finalizers":null}}' --type=merge -n rook-ceph
kubectl --context prod delete cephblockpools ceph-blockpool -n rook-ceph
kubectl --context prod patch cephobjectstores ceph-objectstore -p '{"metadata":{"finalizers":null}}' --type=merge -n rook-ceph
kubectl --context prod delete cephobjectstores ceph-objectstore -n rook-ceph
kubectl --context prod patch CephFilesystemSubVolumeGroup ceph-filesystem-csi -p '{"metadata":{"finalizers":null}}' --type=merge -n rook-ceph
kubectl --context prod delete CephFilesystemSubVolumeGroup ceph-filesystem-csi -n rook-ceph
