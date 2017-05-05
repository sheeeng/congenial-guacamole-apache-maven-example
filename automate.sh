#!/usr/bin/env bash

# Increment version of pom.xml file.
# http://stackoverflow.com/a/36434565
# http://www.mojohaus.org/build-helper-maven-plugin/parse-version-mojo.html

mvn \
build-helper:parse-version versions:set -DnewVersion=\
\${parsedVersion.majorVersion}.\
\${parsedVersion.minorVersion}.\
\${parsedVersion.nextIncrementalVersion} \
versions:commit

mvn clean install \
    --batch-mode \
    --debug \
    --errors \
    --define scmGit.remoteUrl="$(git config --get remote.origin.url)" \
    --define scmGit.branch="$(git rev-parse --abbrev-ref HEAD)" \
    --define scmGit.commitsCount="$(git rev-list HEAD | wc -l)" \
    --define scmGit.revision="$(git rev-parse HEAD)" \
    --define scmGit.shortRevision="$(git rev-parse --short HEAD)" \
    --define scmGit.commitHash="$(git --no-pager show -s --format=%H HEAD)" \
    --define scmGit.abbreviatedCommitHash="$(git --no-pager show -s --format=%h HEAD)" \
    --define scmGit.treeHash="$(git --no-pager show -s --format=%T HEAD)" \
    --define scmGit.abbreviatedTreeHash="$(git --no-pager show -s --format=%t HEAD)" \
    --define scmGit.parentHash="$(git --no-pager show -s --format=%P HEAD)" \
    --define scmGit.abbreviatedParentHash="$(git --no-pager show -s --format=%p HEAD)" \
    --define scmGit.authorName="$(git --no-pager show -s --format=%an HEAD)" \
    --define scmGit.authorEmail="$(git --no-pager show -s --format=%ae HEAD)" \
    --define scmGit.authorDate="$(git --no-pager show -s --format=%ad HEAD)" \
    --define scmGit.authorDateRFC2822="$(git --no-pager show -s --format=%aD HEAD)" \
    --define scmGit.authorDateRelative="$(git --no-pager show -s --format=%ar HEAD)" \
    --define scmGit.authorDateUNIX="$(git --no-pager show -s --format=%at HEAD)" \
    --define scmGit.authorDateISO8601="$(git --no-pager show -s --format=%ai HEAD)" \
    --define scmGit.authorDateISO8601Strict="$(git --no-pager show -s --format=%aI HEAD)" \
    --define scmGit.committerName="$(git --no-pager show -s --format=%cn HEAD)" \
    --define scmGit.committerEmail="$(git --no-pager show -s --format=%ce HEAD)" \
    --define scmGit.committerDate="$(git --no-pager show -s --format=%cd HEAD)" \
    --define scmGit.committerDateRFC2822="$(git --no-pager show -s --format=%cD HEAD)" \
    --define scmGit.committerDateRelative="$(git --no-pager show -s --format=%cr HEAD)" \
    --define scmGit.committerDateUNIX="$(git --no-pager show -s --format=%ct HEAD)" \
    --define scmGit.committerDateISO8601="$(git --no-pager show -s --format=%ci HEAD)" \
    --define scmGit.committerDateISO8601Strict="$(git --no-pager show -s --format=%cI HEAD)" \
    --define scmGit.refNamesDecorate="$(git --no-pager show -s --format=%d HEAD)" \
    --define scmGit.refNames="$(git --no-pager show -s --format=%D HEAD)" \
    --define scmGit.subject="$(git --no-pager show -s --format=%s HEAD)" \
    --define scmGit.sanitizedSubject="$(git --no-pager show -s --format=%f HEAD)" \
    --define scmGit.body="$(git --no-pager show -s --format=%b HEAD)" \
    --update-snapshots

/cygdrive/c/Program\ Files/Java/jdk1.8.0_121/bin/jar xvf ./target/*.jar META-INF/MANIFEST.MF && \
cat META-INF/MANIFEST.MF && \
rm -rfv META-INF

mvn versions:display-dependency-updates

mvn versions:display-plugin-updates

mvn versions:display-property-updates
