mkdir isobuild && cd isobuild
sudo dnf install rpm-ostree lorax -y
git clone -b f36 https://pagure.io/workstation-ostree-config
git clone -b f36 https://pagure.io/fedora-lorax-templates.git
mkdir repo
ostree init --repo=repo
rpm-ostree compose tree --repo=$(pwd)/repo \
	$(pwd)/workstation-ostree-config/fedora-silverblue.yaml

lorax  --product=Fedora \
		--version=36 \
		--release=20180410 \
		--source=https://kojipkgs.fedoraproject.org/compose/36/latest-Fedora-36/compose/Everything/x86_64/os/ \
		--variant=Silverblue \
		--nomacboot \
		--volid=Fedora-SB-ostree-x86_64-36 \
		--add-template=$(pwd)/fedora-lorax-templates/ostree-based-installer/lorax-configure-repo.tmpl \
		--add-template=$(pwd)/fedora-lorax-templates/ostree-based-installer/lorax-embed-repo.tmpl \
		--add-template-var=ostree_install_repo=file://$(pwd)/repo \
		--add-template-var=ostree_update_repo=file://$(pwd)/repo \
		--add-template-var=ostree_osname=fedora \
		--add-template-var=ostree_oskey=fedora-36-primary \
		--add-template-var=ostree_contenturl=mirrorlist=https://ostree.fedoraproject.org/mirrorlist \
		--add-template-var=ostree_install_ref=fedora/36/x86_64/silverblue \
		--add-template-var=ostree_update_ref=fedora/36/x86_64/silverblue \
		--logfile=$(pwd)/lorax.log \
		--tmp=$(pwd)/tmp \
		--rootfs-size=8 \
		$(pwd)/ostree_installer