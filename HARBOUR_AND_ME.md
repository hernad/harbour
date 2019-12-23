Harbour and me 
================

I am producing and delivering software to my users for living. I am doing that constantly for 25 years.

I really know what engineering effort is needed to deliver and maintain `functional` software, software which is `used`. When you deliver software, you have obligations to your clients/users. If you respect those obligations, you are gaining credibility. Otherwise you are going to be out of business.

## Clipper "Era"

### Bosnian War

During the [Bosnia War](https://en.wikipedia.org/wiki/Bosnian_War), I was worked as programmer in [Bosnian Army](https://en.wikipedia.org/wiki/Army_of_the_Republic_of_Bosnia_and_Herzegovina), [3rd Corps (Zenica)](https://en.wikipedia.org/wiki/3rd_Corps_of_the_Army_of_the_Republic_of_Bosnia_and_Herzegovina). We had got a task to implement project of personal evidence with the program produced by the team from [2nd Corps (Tuzla)](https://en.wikipedia.org/wiki/2nd_Corps_of_the_Army_of_the_Republic_of_Bosnia_and_Herzegovina). Before the ond the project, the connections with the  Tuzla's development team have had broken. At the time, there were not internet, no usable [LAN networks](https://en.wikipedia.org/wiki/NetWare). Only computers with few MB of RAM with [`DOS`](https://en.wikipedia.org/wiki/Disk_operating_system) installed, war, lack of food and cigarettes, and destruction.

### My first Clipper project

Let's go back to the personal evidence project. Small part of application were provided with source code, the rest only with binary object files (closed-source). Because of those `closed-source` parts, As we already anticipated many necessary changes covered by closed parts, It was obvious that we cannot deploy the application to our units. It was clear "hit to the wall". We have invested a lot of energy to know the application, and application was good. Nevertheless, the evitable direction of project was cancellation!

At the time, I was 22 years old. I was young, energetic, overly confident. I was brave with my decisions mostly because I was `unaware` of consequences. So I proposed to my chef to rewrite closed part of the application. Even the proposal was not smart, it was accepted. The reason was simple: `We had no better choice`.

The application was built with [`Clipper compiler`](https://en.wikipedia.org/wiki/Clipper_(programming_language)), tool totally unknown to me utill that time. Comparing to my beloved [`Turbo Pascal`](https://en.wikipedia.org/wiki/Turbo_Pascal) Clipper was somekind `ugly`, but really efficient. It was already set out-of-the box for database processing (more precisely "data tables" processing). Data tables manipulation (create, update, search) were integrated into language. That was really great feature.

As you suppose, the crazy adventure of software rewrite had "happy end" after few months. I was really proud. As a side effect, I have learned Clipper a lot. The most important, my work was very soon have proven at the `battlefield` - used by real users.

###  After the War in Bosnia, I have catched [PTSD](https://en.wikipedia.org/wiki/Posttraumatic_stress_disorder) caused by [Vendor-lock in](https://en.wikipedia.org/wiki/Vendor_lock-in) (closed-source) sindrom :)

The moment after ["Dayton Agreement"](https://en.wikipedia.org/wiki/Dayton_Agreement) I have applied for releasing from the Army, and started my software development company. I have developed accounting software which was quite successful at the begin. But then troubles have started...

The GUI applications era started. Microsoft finally made [Windows](https://en.wikipedia.org/wiki/Windows_3.1x) quite usable. Our clients have started to use `Word` and `Excel` :). The list of requestes which we couldn't address was continously raising mostly because the **limits of our developer's toolset**. We have explored other tools, especially [Delphi](https://en.wikipedia.org/wiki/Delphi_(software)). But, we hadn't achieved some substantional results. We produced some tools ([ptxt](https://github.com/bringout-fmk/ptxt), [delphirb](https://github.com/bringout-fmk/delphirb) ) to patch critical deficiencies of our Clipper DOS-based applications, but nothing substantional. We put large efforts, but we hadn't `resources` to write our applications from sratch!

Our business strongly declined. One of the crucial factors was the fact that our essential tool closed-source. The Clipper's acquisition made 1992 (from Nantucket Corporation to Computer Associates - C) was great deal for the seller 190 million USD), but begin of the end for the Clipper itself.
When I now read the name `CA` I feal deap frustration and anger. But, that is the business. The businesses start and fail. Every client put itself on the risk when chose the product.

## year 2000: Linux and open-source software

Here in Bosnia, after the war, we had 5-10 years delay in every aspect comparing to the rest of the world. So, our internet era started around year 2000. That was the time when I have started learn linux. Linux 
was the thing! Operating system free of vendor-lock in. Even more important: **developer tools free of vendor-lock in**! 
After my personal vendor-lock in CA-Clipper disaster, all of my evaluations were influenced by that fact. That have formed my strong opinion:

	Developer's essentential tools have to be open-source software!


## year 2002: Some Delphi with PostgreSQL

Learning about Linux directed me to many other unknown projects. I have learned about SQL, especially MySQL and PostgreSQL. At that time, PostgreSQL was targeted only to unix/linux systems. I have made one internal project with Delphi/PostgreSQL, and it was good. But ... my Vendor lock-in alarm have been activated! Delphi was closed source. Delphi's vendor [Borland](https://en.wikipedia.org/wiki/Borland) was struggling with [Microsoft](https://en.wikipedia.org/wiki/Microsoft), and that was a bad sign. So I decided: no reliance on Delphi. That was a good decision.

## year 2002: Microsoft wins ... (my short .NET era)

In year 2004, I have decided to take "bitter pill" and start future development with Microsoft tools. The main reason behind that decision was: 

	Embrace Microsoft: 
	
	Despite your personal feelings and wishes, the market demants it, they have best developer's tools and resources, so you have to embrace it!

It was also an `easy way` because here in Bosnia all of users and IT proffesionals were exclusively accustomed to Microsoft. Spreaded software piracy was a great ally to keep Microsoft dominacy, because you cannot sell no-Microsoft solutions when your customer thinks that `Microsoft Office` is part of the operationg system and costs 0 USD.

That was time of promoting Microsoft .NET and new C# language. I have liked the language. 

## year 2004: Business, we have the problem - again :(

I have get a good `green-field` project to work on with Microsoft toolset. But his time problems have raised simply becose my personal failures. I was not good as an businessman and project leader. S again, I have droped and experienced classic [burnout](https://en.wikipedia.org/wiki/Occupational_burnout).


## year 2007: Business consolidation

After `burnout` experience, my working habits and approach to business dramatically changed. I have started with "calmly" approach. The basic premises of that approach were:
1. Start saying "NO" to clients, not "WE WILL TRY" when there are no visible solutions which you can provide 
2. Offer things you are **good at**  and you **like to deal with**
3. Support projects which "feeds" you and your company
4. If you cannot support project, **drop** them and tell your clients about that decision
5. Offer your know-how to clients, not software licenses

The effect was this:
1. Microsoft Windows OS and products matters only on client-side
2. Server-side is linux-only
3. Essential developer tools have to be multiplatform
4. We have decided position ourself as "open-source provider" and to open-source all of our projects

## [Harbour](https://en.wikipedia.org/wiki/Harbour_(programming_language)) on the horizont

These choices actually have revived our Clipper projects. For many years they were practically treated as `abandonware`, alive only because they put "food on the table".
So we have started exploring the possible ways for these projects. This time, radical rewrites wasn't option. 
Harbour have seemed as a viable choice. And it was.
Project started some really, really smart guys. Looking at the harbour's source code, it was really crazy endeavor :). All respects to the harbour crew!

During few years, making some good, some really stupid choices (especially this one: [semaphores](https://github.com/hernad/F18/tree/4/core_semafori)) we have ported are core projects to the bave new world of native linux/windows applications :).
As our remaining users was accustomed to CUI (character user interface), that part haven't changed. Our focus was to bring data to SQL server. And that was good choice. The best one.

## Benefits of Harbour with PostgreSQL

Last year we have built brand new POS retail (Point of Sale) system for an existing client. As they have used our old Clipper software in stores, our design choices for new project were next:

POS side:
1. CentOS Linux OS as desktop in POS stores
2. User interface - no substantial changes
4. Total rewrite of database layer and application logic,
 	- use builtin PostgreSQL replication available in version 10.x
	- whenever appropriate, put the logic in [PL/pgSQL](https://en.wikipedia.org/wiki/PL/pgSQL) stored procedures
5. Connection to external MicrosoftSQL source, provide via PostgreSQL foreign interface
6. Docker containers for database servers (Backoffice + every POS store)
6. Automated System and Database upgrades via [Ansible](https://en.wikipedia.org/wiki/Ansible_(software)) following DevOps practices (few dozens of hosts)

Backoffice side (accounting):
1. They alredy had ported/installed our harbour application backed by PostgreSQL database
2. Database cleanup and upgrade according to the changes made at POS side.

From technical standpoint, this approach was a clear success:
1. With ultra-small development crew (1 developer, 1 system administrator):
	- we have built new system within 6-8 month timeframe
	- gradually upgraded to new system without long interruptions (1 day per POS store, 0 days backoffice) interruptions day of interruption in backoffice 
2. All of the `"garbage"` from the old POS software was removed
3. Putting application logic into robust SQL engine. 
	- PostgreSQL replication engine is engineering heaven. It works out-of-box :).
	- PostgreSQL stored procedures are maintainable, debug-able, language easy learnable for developer with harbour background
4. NOT investing time into new UI (User Interface) was crucial time saver either development or deployment phase

## My standpoint about Harbour

I don't consider myself as an `Harbour fun`. In every area of software development, in my opinion, there are better tools available. Let me list my favorites:

- Systems development
	- [golang](https://golang.org/)
	- [rust](https://www.rust-lang.org)
- System administration
	- Ansible (based on python)
- Web development
	- [TypeScript](https://www.typescriptlang.org/)
- Business applications development:
	- java
	- kotlin
	- C#
- Database:
	- PostgreSQL
	- MySQL
	- sqlite
- Reporting engines:
	- jasper reports
	- [yarg](https://github.com/cuba-platform/yarg.git)
- Development tools:
	- Visual Studio Code
	- Atom
- Frameworks and runtime environments
	- java virtual machine (openjdk)
	- .NET core platform
	- nodejs
	- WASM
	- RubyOnRails
	- browser engine :)
- Scripting languages
	- ruby
	- python

My personal developers's experience is that `golang` is the most close to `harbour`. Golang is terse and effective language. It produces native applications with small overhead. But that is the end with similarities. Developer's resources and community are unmatched. And most important, **projects and applications build with golang** are endless.

## Why I'm investing in this project?

I am not talking about harbour as the best solution for new project. The conclusion is that I am NOT harbour language fun. I am investing into harbour because because of those:
1. I am experienced and **know** this language **best**.
2. I deliver solutions to my clients with it (`getting things done`) 
3. I have proved to myself that combined with other tools/technologies, I can build **GOOD** solutions.

Our users don't care about tools we use. They care about the *costs* of the project and the *features* they have!

It is obvious that `harbour` is essential development tool for me, so I am willing to invest the efforts into this project to keep it vital!

## My thoughts about harbour community

Firstly, I have to point out: 

	These statements dependent on personal fields of interest.
	My fields of interest are business applications, not hobbyist usage.


I would like that there are more voices in harbour community about building `bridges` with other technologies rather than making harbour great again :)

For example, providing better GUI solutions would be good thing. Creating some kinde of web framework also. But the problem is - there are much better solutins right now elswere! So that limited time and resources should be put into providing effective interfaces to those frameworks and libraries. 

I am probably most confronted to the community's on the issue of database management in harbour. The community is discussing about client/server DBF base solutions. For mi, it is wrong direction. As I have heard from other users, LetoDB and NETIO are already working in the production. So, if you need to solve problem with accessing large DBF files via network, choose one of those solutions. But I consider those solutions as temporary workarounds! These are not solutions for the future. Future solutions have to be based on some standard SQL engine.
Obviously, I have made my choice - PostgreSQL :)

## Open-source vs closed source, harbour developer's tools vendors

The problems which I have faced with abandoned closed-source product (CA-Clipper) strongly influenced my carrieer and my views. I am big supporter of open-source software.
Linux is my favorite operating sistem either for development or daily usage.
All of relevant software built by my company is also open-source software. 
As much as I know during investigating github.com, our accounting solution [F18](https://github.com/hernad/F18) is the largest harbour based active project.
We don't sell the software itself. We seel `know-how` and `services` around it. 
We consider that model best for us, but for other businesses it may or may be NOT the case.

Of course is totally legitimate to create business around closed-source developer's library for GUI or reporting. But I am generally against using that kind of tools. Especially today, when we have so many high-quality open-source solutions for other programming languages.
I understand that harbour community and related projects (like Xharbour, Xbase++ etc) are small and fragmented. As such, vendors of those developer's tools are functioning in very narrow space.
Anyway, I think they should really analize their existing business models. Somehow rethink themselves, explore how `"new kids on the block"` do their businesses ... If they don't, I am affraid they are going to hurt themselves as much as the whole community.

I am discussing about this topic because we share the same goal: We all want to provide solid, sustainable, healty foundation for harbour programming language and eco-system around it.

## Conclusion

As long as:
1. I can build and upgrade harbour itself
2. Build and maintain solutions around it
3. Keep our customers satisfied with those solutions

Harbour is alive.

Long live the Harbour :)

Ernad