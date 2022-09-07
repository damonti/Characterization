#################################################
# Stratus IDE project file generated;
#################################################
QT       += core

QT       -= gui

CONFIG   += console
CONFIG   -= app_bundle

STRATUSHOME = $$(STRATUS_HOME)
SYSTEMCHOME = $$(SYSTEMC)

TEMPLATE = app
INCLUDEPATH += $${SYSTEMCHOME}/include
INCLUDEPATH += $${SYSTEMCHOME}/include/tlm
INCLUDEPATH += $${STRATUSHOME}/share/stratus/include
INCLUDEPATH += ./bdw_work/wrappers
INCLUDEPATH += ./

SOURCES += \ 
		fir.cc \ 
		main.cc \ 
		system.cc \ 
		tb.cc \ 

HEADERS += \ 
		defines.h \ 
		directives.h \ 
		fir.h \ 
		system.h \ 
		tb.h \ 

OTHER_FILES += \ 
		Makefile \ 
		project.tcl \ 

