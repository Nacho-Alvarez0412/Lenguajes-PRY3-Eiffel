INCLUDE_PATH = 
SHELL = \bin\sh
CC = cl
CPP = cl
CFLAGS = -Od -MT -w -nologo -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -D_CRT_SECURE_NO_DEPRECATE -D_UNICODE -DUNICODE -DWIN32_LEAN_AND_MEAN  -DEIF_THREADS  -DWORKBENCH -I"D:\IDEs\EiffelStudio\studio\spec\win64\include" -I. $(INCLUDE_PATH)
CPPFLAGS = -Od -MT -w -nologo -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -D_CRT_SECURE_NO_DEPRECATE -D_UNICODE -DUNICODE -DWIN32_LEAN_AND_MEAN  -DEIF_THREADS  -DWORKBENCH -I"D:\IDEs\EiffelStudio\studio\spec\win64\include" -I. $(INCLUDE_PATH)
LDFLAGS = -STACK:5000000 -NODEFAULTLIB:libc
CCLDFLAGS = -STACK:5000000 -NODEFAULTLIB:libc  -SUBSYSTEM:CONSOLE
LDSHAREDFLAGS =  -dll -incremental:no -NODEFAULTLIB:libc
EIFLIB = "D:\IDEs\EiffelStudio\studio\spec\win64\lib\msc_vc140\mtwkbench.lib"
EIFTEMPLATES = D:\IDEs\EiffelStudio\studio\config\win64\templates
LIBS = 
MAKE = nmake -s -nologo
AR = 
LD = 
MKDEP =   --
MV = copy
CP = copy
RANLIB = echo
RM = del
FILE_EXIST = if exist
RMDIR = rd
X2C = "D:\IDEs\EiffelStudio\studio\spec\win64\bin\x2c.exe"
SHAREDLINK = link
SHAREDLIBS = USER32.lib WS2_32.lib ADVAPI32.lib GDI32.lib SHELL32.lib MSIMG32.lib \
	COMDLG32.lib UUID.lib OLE32.lib OLEAUT32.lib COMCTL32.lib MPR.LIB SHLWAPI.LIB WINSPOOL.LIB 
SHARED_SUFFIX = .dll
COMMAND_MAKEFILE = 
START_TEST = if not exist finished 
END_TEST =  
CREATE_TEST = echo "finished" >> finished 
SYSTEM_IN_DYNAMIC_LIB = json_handler.dll 

.SUFFIXES:.cpp .obj 

.c.obj:
	$(CC) $(CFLAGS) -c $<

.cpp.obj:
	$(CPP) $(CPPFLAGS) -c $<

SUBDIRS = C1 E1

EXTERNALS = 

all:: json_handler.exe
	echo done > completed.eif

C1\Cobj1.lib: Makefile E1\estructure.h
	cd C1
	$(START_TEST) $(MAKE) Cobj1.lib $(END_TEST)
	cd ..

E1\emain.obj:  Makefile E1\Makefile
	$(CP) "$(EIFTEMPLATES)\emain.template" "E1\emain.c"
	cd E1
	$(START_TEST) $(MAKE) emain.obj  $(END_TEST)
	cd ..

E1\eoption.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) eoption.obj  $(END_TEST)
	cd ..

E1\epattern.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) epattern.obj  $(END_TEST)
	cd ..

E1\efrozen.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) efrozen.obj  $(END_TEST)
	cd ..

E1\ecall.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) ecall.obj  $(END_TEST)
	cd ..

E1\eplug.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) eplug.obj  $(END_TEST)
	cd ..

E1\eskelet.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) eskelet.obj  $(END_TEST)
	cd ..

E1\enames.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) enames.obj  $(END_TEST)
	cd ..

E1\evisib.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) evisib.obj  $(END_TEST)
	cd ..

E1\ececil.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) ececil.obj  $(END_TEST)
	cd ..

E1\einit.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) einit.obj  $(END_TEST)
	cd ..

E1\eparents.obj : Makefile E1\Makefile E1\estructure.h
	cd E1
	$(START_TEST) $(MAKE) eparents.obj  $(END_TEST)
	cd ..

OBJECTS = E1\eparents.obj  E1\einit.obj  E1\ececil.obj  E1\evisib.obj  E1\enames.obj  E1\eskelet.obj  E1\eplug.obj  E1\ecall.obj  E1\efrozen.obj  E1\epattern.obj  E1\eoption.obj  C1\Cobj1.lib 

C_OBJECTS = C1\Cobj1.lib 

EOBJECTS = E1\eparents.obj  E1\einit.obj  E1\ececil.obj  E1\evisib.obj  E1\enames.obj  E1\eskelet.obj  E1\eplug.obj  E1\ecall.obj  E1\efrozen.obj  E1\epattern.obj  E1\eoption.obj  

PRECOMP_OBJECTS= "c:\users\nacho\onedrive\documentos\eiffel user files\20.11\precomp\spec\win64\EIFGENs\base-scoop-safe\W_code\msc_vc140\precomp.lib"


json_handler.exe: json_handler.lnk json_handler.res
	$(COMMAND_MAKEFILE)
	link @json_handler.lnk

..\..\..\json_handler.rc:
	if not exist ..\..\..\json_handler.rc $(MV) "D:\IDEs\EiffelStudio\studio\config\win64\msc_vc140\eiffel.rc" ..\..\..\json_handler.rc

json_handler.res: ..\..\..\json_handler.rc Makefile
	rc -r -fojson_handler.res ..\..\..\json_handler.rc

json_handler.lnk: $(OBJECTS) e1\emain.obj json_handler.res Makefile
	if exist $@ $(RM) $@
	@echo $(LDFLAGS) $(CCLDFLAGS) -OUT:json_handler.exe >> $@
	@echo e1\emain.obj >> $@
	@echo $(EIFLIB)  >> $@
	@echo USER32.lib WS2_32.lib ADVAPI32.lib GDI32.lib SHELL32.lib MSIMG32.lib \
	COMDLG32.lib UUID.lib OLE32.lib OLEAUT32.lib COMCTL32.lib MPR.LIB SHLWAPI.LIB WINSPOOL.LIB $(ISE_SHAREDLIBS) $(PRECOMP_OBJECTS) >> $@
	@echo json_handler.res >> $@
	echo E1\eparents.obj  E1\einit.obj  E1\ececil.obj  E1\evisib.obj  E1\enames.obj   >> $@ 
	echo E1\eskelet.obj  E1\eplug.obj  E1\ecall.obj  E1\efrozen.obj  E1\epattern.obj   >> $@ 
	echo E1\eoption.obj  C1\Cobj1.lib  >> $@ 


RCECIL = MTdebug.obj MTidrs.obj MTinterp.obj mtipc.obj MTnetwork.obj MTupdate.obj \
	MTwargv.obj MTwbench.obj MTwboolstr.obj MTwcecil.obj MTwcompress.obj \
	MTwconsole.obj MTwcopy.obj MTwdir.obj MTweif_project.obj MTweif_threads.obj \
	MTweif_type_id.obj MTwequal.obj MTwerror.obj MTweveqs.obj MTwexcept.obj  \
	MTwfile.obj MTwgarcol.obj MTwgen_conf.obj MTwhash.obj MTwhashin.obj MTwhector.obj \
	MTwinternal.obj MTwlmalloc.obj MTwlocal.obj MTwmain.obj MTwmalloc.obj \
	MTwmemory.obj MTwmemory_analyzer.obj MTwmisc.obj MTwnotify_token.obj \
	MTwobject_id.obj MTwoffset.obj MTwoption.obj MTwout.obj MTwpath_name.obj \
	MTwplug.obj MTwposix_threads.obj MTwprivate_queue.obj MTwprocessor.obj \
	MTwprocessor_registry.obj MTwqueue_cache.obj MTwreq_grp.obj MTwretrieve.obj \
	MTwrout_obj.obj MTwrun_idr.obj MTwscoop.obj MTwscoop_gc.obj MTwsearch.obj \
	MTwsig.obj MTwstore.obj MTwtimer.obj MTwtools.obj MTwtraverse.obj MTwumain.obj \
	MTwurgent.obj 


#STATIC_CECIL PART
STATIC_CECIL = libjson_handler.lib
cecil: $(STATIC_CECIL)
$(STATIC_CECIL): $(OBJECTS) $(EIFLIB) 
	if exist $@ $(RM) $@
	lib -nologo -OUT:$(STATIC_CECIL) $(OBJECTS) $(EXTERNALS) $(EIFLIB) $(PRECOMP_OBJECTS)



#SHARED_CECIL PART
SHARED_CECIL = libjson_handler$(SHARED_SUFFIX)
dynamic_cecil: $(SHARED_CECIL) 
DEF_FILE= c_json_handler.def 
c_json_handler.def: 
	if exist $@ $(RM) $@
	echo LIBRARY libjson_handler.dll > $@
	type "D:\IDEs\EiffelStudio\studio\config\win64\templates\cecil.def"  >> $@

SHARED_CECIL_OBJECT = $(OBJECTS) \
		E1/emain.obj
SHAREDFLAGS = $(LDSHAREDFLAGS) \
	/def:$(DEF_FILE) \
	/OUT:$(SHARED_CECIL) /IMPLIB:c_dll_json_handler.lib

$(SHARED_CECIL): $(SHARED_CECIL_OBJECT)  $(DEF_FILE)
	if exist $(SHARED_CECIL) del $(SHARED_CECIL)
	$(SHAREDLINK) $(SHAREDFLAGS) $(SHARED_CECIL_OBJECT) $(PRECOMP_OBJECTS) $(EXTERNALS) $(EIFLIB) $(SHAREDLIBS) 

#SYSTEM_IN_DYNAMIC_LIB PART

DEF_FILE= json_handler.def
dynlib: $(SYSTEM_IN_DYNAMIC_LIB) 
E1\egc_dynlib.obj: Makefile E1\Makefile
	$(CP) "$(EIFTEMPLATES)\egc_dynlib.template" E1\egc_dynlib.c
	cd E1
	$(MAKE) egc_dynlib.obj
	cd ..
E1\edynlib.obj: Makefile E1\Makefile E1\edynlib.c 
	cd E1
	$(MAKE) edynlib.obj
	cd ..

SYSTEM_IN_DYNAMIC_LIB_OBJ = $(OBJECTS) \
		E1\edynlib.obj E1\egc_dynlib.obj 
DYNLIBSHAREDFLAGS = $(LDSHAREDFLAGS) \
	/def:$(DEF_FILE) \
	/OUT:$(SYSTEM_IN_DYNAMIC_LIB) /IMPLIB:dll_json_handler.lib json_handler.res

$(SYSTEM_IN_DYNAMIC_LIB): $(SYSTEM_IN_DYNAMIC_LIB_OBJ)  $(DEF_FILE)
	if exist $(SYSTEM_IN_DYNAMIC_LIB) del $(SYSTEM_IN_DYNAMIC_LIB)
	$(SHAREDLINK) $(DYNLIBSHAREDFLAGS) $(SYSTEM_IN_DYNAMIC_LIB_OBJ) $(PRECOMP_OBJECTS) $(EXTERNALS) $(EIFLIB) $(SHAREDLIBS) 



clean: sub_clean local_clean
clobber: sub_clobber local_clobber

local_clean::
	$(RM) core finished *.obj *.so *.a

local_clobber:: local_clean
	$(RM) Makefile config.sh finish_freezing

sub_clean::
	for i in $(SUBDIRS); \
	do \
		if [ -r $$i\Makefile ]; then \
			(cd $$i ; $(MAKE) clean); \
		fi; \
	done

sub_clobber::
	for i in $(SUBDIRS); \
	do \
		if [ -r $$i\Makefile ]; then \
			(cd $$i ; $(MAKE) clobber); \
		fi; \
	done

