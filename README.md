# Nextflow: R package caching/versioning, custom code distribution to nodes

This is a simple skeleton project demonstrating how to manage R projects with nextflow.  Two use cases are presented:

1. Version locking of script dependencies.  Making these versioned dependencies available on a prebuilt image. Script-dependent selection of dependency version.
2. Exporting custom code to nextflow nodes but not exposing it to PATH via ./bin.

## Versioning and caching script dependencies
The R package renv is used to manage dependencies on the image and build dependency manifest files. These manifests are shared with the docker image at build time to allow caching.  They are then activated at runtime to guarantee the correct verion of each dependency is used.

## Exporting custom code
The desired code is passed in a nextflow input argument to the node and referenced there.  A cleaner handling of this type of functionality is being discussed here: https://github.com/nextflow-io/nextflow/issues/1798nextflow#1798