// A dummy pipeline so we can run builds in parallel.
local ignoreThisPipeline() = {
    name: "ignore-this-pipeline",
    kind: "pipeline",
    type: "docker",
    steps: []
};

local updatePackages(pkgbase) = {
    name: "update-" + pkgbase,
    kind: "pipeline",
    type: "docker",
    depends_on: ["ignore-this-pipeline"],
    steps: [{
        name: "update-" + pkgbase,
        image: "proget.hunterwittenborn.com/docker/makedeb/makedeb:ubuntu-jammy",
        environment: {
            pkgbase: pkgbase,
	        ssh_key: {from_secret: "ssh_key"},
            github_api_key: {from_secret: "github_api_key"},
            gitlab_api_key: {from_secret: "gitlab_api_key"}
        },
        commands: [
            "sudo chown 'makedeb:makedeb' ./ -R",
            ".drone/scripts/setup.sh",
            "scripts/" + pkgbase + ".sh"

        ]
    }]
};

[
    ignoreThisPipeline(),
    updatePackages("bats"),
    updatePackages("chezmoi"),
    updatePackages("docker-compose"),
    updatePackages("drone-cli"),
    updatePackages("element-desktop-bin"),
    updatePackages("fd"),
    updatePackages("glab"),
    updatePackages("golang-go"),
    updatePackages("google-chrome-stable"),
    updatePackages("hugo"),
    updatePackages("just"),
    updatePackages("mist-bin"),
    updatePackages("neovim"),
    updatePackages("rustc")
]