Building mess
========================================

On `harbour-users` group:

> How to deal with binary compatibility libraryV1, libraryV2

Try to think different:

If I have all what I need available with me, I am sure that everything is fine :)
Agile harbour contains every library my application F18 needs. All of the libraries are build from source. 

But you are right. That is enough only for me. There are next cases:

1. There are proprietary libraries you can need

In this case, you have to deal with binary compatibility:
-  provide naming and linking  libProprietary1, libProprietary2, with harbour bindings hbProprietary1, hbProprietary2 ...

**This naming is neccessary ONLY if you need side-by-usage**

2. There are open-source libraries not included in harbour binary distribution

The same concept if you have binaries available.

But let me answer to your first question, and maybe the more important statement in all of this talk:

4.7.2 agile harbour is built with postgresql 12.1

I want postgresql 12.2 newly released because super-duper replication thing. What would I have done:

- opening postgresql-12.2 branch in agile harbour
- removing 12.1 postgresql source, changing with 12.2. testing build - ok - releasing harbour version 4.8.0

After that, I have new version of my tool with inclusion of new library.
If I am cautious, I will leave 20-30 days thing in separate branch, if everything is ok - merging to main branch, continue with development.

So this way everything of vital importance to my application is ok.

I "eat food" I make, so this concept is already applied to my F18 project https://github.com/hernad/F18/blob/4/package.json#L4
My build engine (azure-pipelines) is building already with agile harbour like this. Fresh stuff :)

Binaries are available at bintray.com. And azure pipelines are available, as you can see. 
So, It may be at the and that my continuous build system practices are solution which make your big problems much smaller.
You can imagine, I can set publishing different versions of my application at once .  

I am doing that already here: https://github.com/hernad/vscode-f18/blob/4/ext/constants.ts#L8
There are three channels of application user can have: S - standard, E - edge, X - experimental.

## Avoid Side-by-side libraries!

Side-by-side usage should be avoided wherever you can.
 Because of clarity. Binding everything in one build chain is the clearest approach.
In my example:

- agile harbour 4.8.0  <-> postgresql 12.2
- agile harbour 4.7.2  <-> postgresql 12.1

My application F18:

- F18 4.4.20 (built with ah 4.7.2)
- F18 4.5.0 (built with ah 4.8.0)


## "Fork", that ugly word

I am really suprised by people's reactions. I have put my efforts to explain topic, then I realize that first thing 
in their mind is `He want's to promote his project`?! Because of that, I suppose they cannot focus on my explanation at all:


> I am explaining you that  answer to your question is firmly connected with building policies of the tool you are using.

> You can apply that on any project. I have used my projects FOR THE SAKE OF EXPLANATION. And it is something you can observe and analyze. All of my projects are open-source, so it is allowed to you. You will not be infected looking at my solutions.

> My intention to write this wasn't to use my project, then to share my engineering knowledge. So, It would be nice to say: "Thank you Ernad", not to think that I want you to attract you to my "fork". Especially because this community consider forks as ugly things (which they are not).

> So you have to learn: Be grateful to others when they share knowledge. Knowledge is the most important thing in every industry, especially in software industry.

> Let me get back:  Your project can take better building policies and make your life easier and your productivity greater. Without that you are going to have `building hell`.
Simple as that.