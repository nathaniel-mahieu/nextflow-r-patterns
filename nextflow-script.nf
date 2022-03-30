#!/usr/bin/env nextflow

process rScript {
    container 'docker-r'
    
    input:
    // This makes the code available on the node.  Note: better solutions are being discussed: https://github.com/nextflow-io/nextflow/issues/2240
    path ASSETS, stageAs: 'assets' from "$projectDir/assets"

    script:
    """
    #!/usr/bin/env Rscript

    # Uses the dependencies which have already been cached on our docker image (as long as this renv.lock was present when the docker image was built)
    renv::restore(lockfile="${ASSETS}/r-project-1/renv.lock", prompt=F)
    
    # Allows R to reference the nextflow ./assets directory
    ASSETS = ${ASSETS}

    # Runs a script from the ./assets directory
    source( file.path(ASSETS, r"(/r-project-1/r-script-1.R)") )
    """
}