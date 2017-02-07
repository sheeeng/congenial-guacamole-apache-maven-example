# Increment version of pom.xml file.
# http://stackoverflow.com/a/36434565
# http://www.mojohaus.org/build-helper-maven-plugin/parse-version-mojo.html

rainbow --config=mvn3 -- mvn \
build-helper:parse-version versions:set -DnewVersion=\
\${parsedVersion.majorVersion}.\
\${parsedVersion.minorVersion}.\
\${parsedVersion.nextIncrementalVersion} \
versions:commit

rainbow --config=mvn3 -- mvn \
-DinteractiveMode=false \
-Dgitenv.remoteurl=$(git config --get remote.origin.url) \
-Dgitenv.branchname=$(git rev-parse --abbrev-ref HEAD) \
-Dgitenv.commitsCount=$(git rev-list HEAD | wc -l) \
-Dgitenv.revision=$(git rev-parse HEAD) \
-Dgitenv.shortrevision=$(git rev-parse --short HEAD) \
clean deploy && \
jar xvf target/original-*.jar META-INF/MANIFEST.MF && \
cat META-INF/MANIFEST.MF
rm -rfv META-INF
