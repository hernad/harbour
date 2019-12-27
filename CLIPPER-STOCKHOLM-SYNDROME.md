Clipper Stockholm syndrome
=================================

Harbour [source code base](https://github.com/hernad/harbour-core) is so occupied by Clipper. I have searched term "CLIPPER" in vscode harbour-core.
There are **2345** mentions in 330 files.

I have started "DE-Clipperization" of harbour in project [agile harbour](https://github.com/hernad/harbour). 
Searching "CLIPPER" in that code base resulted with 1678 mentions in 187 files.
Because of that, this morning (27.12.2019) I deleted old ChangeLog.txt. Now, result is **610** mention in 186 files. 

It seems to me that this community has CLIPPER Stockholm syndrome. We shoud get rid of that. 
Continous mentioning of old days and clipper is contra-productive especially for somebody outside that story.

In practice, as a programmer, I really don't care about Clipper compatibility. So I have reached  so much clarity removing these switches:
HB_COMPAT_C53 - always on, HB_CLP_STRICT - always off, HB_CLP_UNDOC - always on.

Clipper is dead. We are harbour community. We should ask ourselves what we shoud make with harbour and harbour only.

