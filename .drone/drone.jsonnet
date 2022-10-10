local updatePackages(pkgbase) = {
    name: "update-" + pkgbase,
    kind: "pipeline",
    type: "docker",
    steps: [{
        name: "update-" + pkgbase,
        image: "proget.hunterwittenborn.com/docker/makedeb/makedeb:ubuntu-jammy",
        environment: {
            pkgbase: pkgbase,
	        ssh_key: {from_secret: "ssh_key"},
            github_api_key: {from_secret: "github_api_key"}
        },
        commands: [
            "sudo chown 'makedeb:makedeb' ./ -R",
            ".drone/scripts/setup.sh",
            "scripts/" + pkgbase + ".sh"

        ]
    }]
};

[
    updatePackages("docker-compose"),
    // updatePackages("google-chrome-stable"),
    // updatePackages("hugo"),
    // updatePackages("just"),
]