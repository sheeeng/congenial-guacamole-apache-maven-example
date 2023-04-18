# congenial-guacamole-apache-maven-example

* Build Apache Maven project.

* Deploy build artifacts to Sonotype Nexus repository.

## Prerequisites

* Download and extract OpenJDK archive. For example, [OpenJDK 20](https://jdk.java.net/20/).

```shell
tar -xvf openjdk-20_macos-x64_bin.tar.gz
sudo mv jdk-20.jdk /Library/Java/JavaVirtualMachines/
```

* Open [.envrc](https://direnv.net/) and add the following entries at the end of it.

```text
source_env ${HOME}

JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home"
PATH="${JAVA_HOME}/bin:${PATH}"
export PATH
```

* Run `direnv allow` to approve its content.

* Verify the JDK Installation

```console
$ java --version
openjdk 20 2023-03-21
OpenJDK Runtime Environment (build 20+36-2344)
OpenJDK 64-Bit Server VM (build 20+36-2344, mixed mode, sharing)
```

* Download and extract Apache Maven archive. For example, [Apache Maven 3.9.1](https://maven.apache.org/download.cgi).

```shell
tar -xvf apache-maven-3.9.1-bin.tar.gz
```

* Update [.envrc](https://direnv.net/) with the following entries at the end of it.

```text
source_env ${HOME}

JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home"
PATH="${JAVA_HOME}/bin:${PATH}"
export PATH

export M2_HOME="${HOME}/Downloads/apache-maven-3.9.1"
PATH="${M2_HOME}/bin:${PATH}"
export PATH
```

* Run `direnv allow` to approve its content.

* Verify Apache Maven installation.

```shell
$ mvn -version
Apache Maven 3.9.1 (2e178502fcdbffc201671fb2537d0cb4b4cc58f8)
Maven home: /Users/lssl/Downloads/apache-maven-3.9.1
Java version: 20, vendor: Oracle Corporation, runtime: /Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home
Default locale: en_GB, platform encoding: UTF-8
OS name: "mac os x", version: "13.3.1", arch: "x86_64", family: "mac"
```

## TODO

* How to run jar file after `mvn package`?

```console
$ java -classpath target/original-congenial-guacamole-0.0.0.null.jar guacamole.PotatoMain
Exception in thread "main" java.lang.NoClassDefFoundError: org/joda/time/LocalTime
        at guacamole.PotatoMain.main(PotatoMain.java:12)
Caused by: java.lang.ClassNotFoundException: org.joda.time.LocalTime
        at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:641)
        at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:188)
        at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:521)
        ... 1 more
$ java -jar target/original-congenial-guacamole-0.0.0.null.jar
Exception in thread "main" java.lang.NoClassDefFoundError: org/joda/time/LocalTime
        at guacamole.PotatoMain.main(PotatoMain.java:12)
Caused by: java.lang.ClassNotFoundException: org.joda.time.LocalTime
        at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:641)
        at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:188)
        at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:521)
        ... 1 more
```
