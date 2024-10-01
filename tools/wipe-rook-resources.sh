#!/bin/bash

# remove all rook resources
kubectl patch cephfilesystems ceph-filesystem -p '{"metadata":{"finalizers":null}}' --type=merge -n rook-ceph
kubectl delete cephfilesystems ceph-filesystem -n rook-ceph
kubectl patch cephblockpools ceph-blockpool -p '{"metadata":{"finalizers":null}}' --type=merge -n rook-ceph
kubectl delete cephblockpools ceph-blockpool -n rook-ceph
kubectl patch cephobjectstores ceph-objectstore -p '{"metadata":{"finalizers":null}}' --type=merge -n rook-ceph
kubectl delete cephobjectstores ceph-objectstore -n rook-ceph
kubectl patch CephFilesystemSubVolumeGroup ceph-filesystem-csi -p '{"metadata":{"finalizers":null}}' --type=merge -n rook-ceph
kubectl delete CephFilesystemSubVolumeGroup ceph-filesystem-csi -n rook-ceph