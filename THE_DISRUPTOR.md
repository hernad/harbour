The Disruptor
==================

I think that there are to main problems with harbour project:

## 1. There is no prominent open-source software built around project

There are numerous examples, where language projects are ceasing not because the are by the engineering point bad, but they have no applications around it.
For example look at Dart language. Millions of dollars have spent to the language by the google, but it didn't succeed  ... until  Flutter (https://flutter.dev/) have published.
Ruby has RoR, python has numpy and billion of other projects, golang has docker and numerous other. Harbour have not single one prominent project!

## 2. The community is rigid

The community is not ready to accept, even discuss that It should embrace as goals to adopt and learn other tools as must-have(for example SQL management), reporting (for example: make good bridge with Java/JasperReports).

Along with adopting "new worlds", the community is not ready to mark some parts as pure legacy which has no future.

For example i think that main putting efforts into GUI library and/or WEB GUI is path wich leads to small benefits. Why?

Because there are good matured solutions with other languages.
I suppose that community is putting efforts to desktop GUI because they ignore the fact: people should avoid build MONOLIT
applications. They should build client frontend as one subproject, backend as another.
Harbour HAS already good enough frontend for an accountant's data entry  - yes it is CUI interface.
But for another uses, harbour developers should adopt new technologies. Example>

You can see on my github page https://github.com/hernad/
these projects:
- eShell - it is in the essence trimmed Visual studio code project used as host of our new desktop application
- vscode-f18  - it is extension which downloads our CUI F18-client harbour application and shows it in eShell web window
- vscode-postgresql - used to setup postgresql connection (F18-client is launched with parameters get from this extension)
- vscode-pdf - view of pdf document in another tab of eShell

With this approach I have connected my "old-school" harbour project with new worlds.

In another thread, one honored colleague sad that I am disruptor. I suppose he is right.
That is the way I work in this community either in my personal projects.

If there is something useful to others - it is available as open-source software. If it is not, I will continue to disrupt only myself.
