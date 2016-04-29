#!/bin/bash

CONTROL_REPO="https://github.com/puppet-br/pcp-controlrepo"

yum install -y git

rm -rf /etc/puppetlabs/code/*
rm -rf /etc/puppetlabs/puppet/ssl

/opt/puppetlabs/puppet/bin/gem install --no-ri --no-rdoc r10k

mkdir -p /etc/puppetlabs/r10k
cat > /etc/puppetlabs/r10k/r10k.yaml <<EOF
---
:cachedir: /opt/puppetlabs/server/data/puppetserver/r10k
:sources:
  puppet:
    basedir: /etc/puppetlabs/code/environments
    remote: $CONTROL_REPO
EOF

/opt/puppetlabs/puppet/bin/r10k deploy environment production -v debug --puppetfile

puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp