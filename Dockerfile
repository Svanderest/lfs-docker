FROM archlinux:latest

ENV LFS=/mnt/lfs

RUN pacman --noconfirm -Sy base-devel python arch-install-scripts wget

RUN mkdir -p /sources/files

RUN mkdir -p scripts/{toolchain-scripts,chroot-build-scripts}

RUN chmod a+wt /sources

RUN groupadd lfs

RUN useradd -s /bin/bash -g lfs -m -k /dev/null lfs

COPY toolchain-scripts/* /scripts/toolchain-scripts/

COPY chroot-build-scripts/* /scripts/chroot-build-scripts/

COPY scripts/* /scripts/

COPY files/lfs.bash_profile /home/lfs/.bash_profile

COPY files/lfs.bashrc /home/lfs/.bashrc

COPY files/* /sources/files/

RUN wget --input-file=/sources/files/wget-list --continue --directory-prefix=/sources

ENTRYPOINT ["/scripts/entrypoint"]
