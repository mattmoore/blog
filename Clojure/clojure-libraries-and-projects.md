# Clojure Projects: Apps and Libraries

The two main types of projects in Clojure are apps and libraries. These can be created very easily:

```shell
# New library
lein new mylib

# New app
lein new app hello-world
```

An app is a standalone program that will contain a main method. It's the entry point of the program when it gets deployed. The library project is a code library that can be called by the hello-world app, as well as by other projects.

Here are the contents of the two projects we just created:

```shell
mylib
├── CHANGELOG.md
├── LICENSE
├── README.md
├── doc
│   └── intro.md
├── project.clj
├── resources
├── src
│   └── mylib
│       └── core.clj
└── test
    └── mylib
        └── core_test.clj
```

```shell
hello-world
├── CHANGELOG.md
├── LICENSE
├── README.md
├── doc
│   └── intro.md
├── project.clj
├── resources
├── src
│   └── hello_world
│       └── core.clj
└── test
    └── hello_world
        └── core_test.clj
```

The main files I'm concerned with here are the src files. In mylib, there is a src/mylib/core.clj file. This is where we can add functions, though it's not the only place. We can add multiple clj files. The other file I'm interested in is the project.clj file. That lets us define various aspects of our project:

```clojure
(defproject mylib "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]])
```

Next, open src/mylib/core.clj:

```clojure
(ns mylib.core)

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))
```

Notice there's already a function called (foo). For now, let's leave that there. Let's also add another function called (greet):

```clojure
(ns mylib.core)

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))

(defn greet
  "I greet people when they call my name."
  [name]
  (format "Hello, %s!" name))
```

Save that file. The next thing you need is to package the library into a jar file for distribution, the same as any Java project. But first, let's install maven to manage this package as a dependency on our system. Maven is a dependency management tool popular in the Java community.

```shell
# macOS Sierra:
brew install maven

# Debian system (Ubuntu, etc...)
sudo apt install maven
```

Now to create the jar file and install it to your local maven repo:

```shell
# Create jar
lein jar
Created target/io.mattmoore.mylib-0.1.0-SNAPSHOT.jar

# Install jar file to local maven repository
mvn install:install-file -DgroupId=io.mattmoore \
                         -DartifactId=mylib \
                         -Dversion=0.1.0 \
                         -Dpackaging=jar \
                         -Dfile=target/io.mattmoore.mylib-0.1.0-SNAPSHOT.jar
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Maven Stub Project (No POM) 1
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-install-plugin:2.4:install-file (default-cli) @ standalone-pom ---
[INFO] Installing /Users/mpm/source/clojure/mylib/target/io.mattmoore.mylib-0.1.0-SNAPSHOT.jar to
[INFO]   /Users/mpm/.m2/repository/io/mattmoore/mylib/0.1.0/mylib-0.1.0.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 0.329 s
[INFO] Finished at: 2017-05-07T20:22:03-05:00
[INFO] Final Memory: 10M/309M
[INFO] ------------------------------------------------------------------------
```

We can now make use of that jar file in our application project. In the future, if I want to make changes to the mylib jar that I created, I can run the lein jar command in the mylib project directory, then the 'mvn install:install-file' command above.

Now, let's open hello-world/project.clj:

```clojure
(defproject hello-world "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]]
  :main ^:skip-aot hello-world.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
```

Let's add mylib to the :dependencies of hello-world and also add the local repository it comes from to :repositories:

```clojure
(defproject hello-world "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [io.mattmoore/mylib "0.1.0"]]
  :repositories {"io.mattmoore" "file:.m2"}
  :main ^:skip-aot hello-world.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
```

Save the file.

You won't need to do this all the time, but I wanted to show the deps task will download and install any missing libraries from your local maven repository. You can confirm that the library has been properly fetched and installed by passing the :tree keyword to the deps task:

```shell
lein deps :tree
 [clojure-complete "0.2.4" :exclusions [[org.clojure/clojure]]]
 [io.mattmoore/mylib "0.1.0"]
 [org.clojure/clojure "1.8.0"]
 [org.clojure/tools.nrepl "0.2.12" :exclusions [[org.clojure/clojure]]]
```

Notice our io.mattmoore/mylib library has been added. Now we are ready to call it in our hello-world app. Inside hello-world, open the file src/hello_world/core.clj:

```clojure
(ns hello-world.core
  (:gen-class))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))
```

Modify it to look like this:

```clojure
(ns hello-world.core
  (:gen-class))

(use 'mylib.core)

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!")
  (println (mylib.core/greet "Matt")))
```

I've added another println call to (mylib.core/greet "Matt") which, as you can see if you run it, will execute the greet function I defined in mylib:

```shell
lein run
Hello, World!
Hello, Matt!
```

And that's all there is to it! But wait, what if I want to pass in my name to Clojure rather than hard-coding it? We can modify src/hello_world/core.clj:

```clojure
(ns hello-world.core
  (:gen-class))

(use 'mylib.core)

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!")
  (println (mylib.core/greet (first args))))
```

Notice in the main function there is a vector [& args]. In Clojure, '&' signifies a variadic function. This tells the compiler that there is a variable number of parameters, in this case stored in args. args is populated with the command line arguments. I'm passing args to the (first) function. As its name suggests, (first) returns the first item in the collection. To run this:

```shell
lein run "Matt Moore"
Hello, World!
Hello, Matt Moore!
```

Now what if we want to ship our final program? Leiningen provides a task to create an "uberjar" which is a standalone jar that can be run on any system with Java installed:

```shell
lein uberjar
Compiling hello-world.core
Created target/uberjar/hello-world-0.1.0-SNAPSHOT.jar
Created target/uberjar/hello-world-0.1.0-SNAPSHOT-standalone.jar
```

To run the final jar on any Java-ready system:

```shell
java -jar target/uberjar/hello-world-0.1.0-SNAPSHOT-standalone.jar "Matt Moore"
Hello, World!
Hello, Matt Moore!
```
