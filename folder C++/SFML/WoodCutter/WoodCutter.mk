##
## Auto Generated makefile by CodeLite IDE
## any manual changes will be erased      
##
## Debug
ProjectName            :=WoodCutter
ConfigurationName      :=Debug
WorkspacePath          :=/media/vnvdmit/msdos/tmp
ProjectPath            :=/media/vnvdmit/msdos/tmp/Woodcutter
IntermediateDirectory  :=./Debug
OutDir                 := $(IntermediateDirectory)
CurrentFileName        :=
CurrentFilePath        :=
CurrentFileFullPath    :=
User                   :=Дмитрий Военнов
Date                   :=09/04/21
CodeLitePath           :=/home/vnvdmit/.codelite
LinkerName             :=/usr/bin/g++
SharedObjectLinkerName :=/usr/bin/g++ -shared -fPIC
ObjectSuffix           :=.o
DependSuffix           :=.o.d
PreprocessSuffix       :=.i
DebugSwitch            :=-g 
IncludeSwitch          :=-I
LibrarySwitch          :=-l
OutputSwitch           :=-o 
LibraryPathSwitch      :=-L
PreprocessorSwitch     :=-D
SourceSwitch           :=-c 
OutputFile             :=$(IntermediateDirectory)/$(ProjectName)
Preprocessors          :=
ObjectSwitch           :=-o 
ArchiveOutputSwitch    := 
PreprocessOnlySwitch   :=-E
ObjectsFileList        :="WoodCutter.txt"
PCHCompileFlags        :=
MakeDirCommand         :=mkdir -p
LinkOptions            :=  
IncludePath            :=  $(IncludeSwitch). $(IncludeSwitch). 
IncludePCH             := 
RcIncludePath          := 
Libs                   := $(LibrarySwitch)sfml-graphics $(LibrarySwitch)sfml-window $(LibrarySwitch)sfml-audio $(LibrarySwitch)sfml-system 
ArLibs                 :=  "sfml-graphics" "sfml-window" "sfml-audio" "sfml-system" 
LibPath                := $(LibraryPathSwitch). 

##
## Common variables
## AR, CXX, CC, AS, CXXFLAGS and CFLAGS can be overriden using an environment variables
##
AR       := /usr/bin/ar rcu
CXX      := /usr/bin/g++
CC       := /usr/bin/gcc
CXXFLAGS :=  -g -O0 -Wall $(Preprocessors)
CFLAGS   :=  -g -O0 -Wall $(Preprocessors)
ASFLAGS  := 
AS       := /usr/bin/as


##
## User defined environment variables
##
CodeLiteDir:=/usr/share/codelite
Objects0=$(IntermediateDirectory)/NoMusic.cpp$(ObjectSuffix) $(IntermediateDirectory)/Player.cpp$(ObjectSuffix) $(IntermediateDirectory)/Bee.cpp$(ObjectSuffix) $(IntermediateDirectory)/Branches.cpp$(ObjectSuffix) $(IntermediateDirectory)/Cloud.cpp$(ObjectSuffix) $(IntermediateDirectory)/Log.cpp$(ObjectSuffix) $(IntermediateDirectory)/game.cpp$(ObjectSuffix) $(IntermediateDirectory)/Draw.cpp$(ObjectSuffix) $(IntermediateDirectory)/Gamebject.cpp$(ObjectSuffix) $(IntermediateDirectory)/Gravestone.cpp$(ObjectSuffix) \
	$(IntermediateDirectory)/Input.cpp$(ObjectSuffix) $(IntermediateDirectory)/Tree.cpp$(ObjectSuffix) $(IntermediateDirectory)/Axe.cpp$(ObjectSuffix) $(IntermediateDirectory)/Update.cpp$(ObjectSuffix) $(IntermediateDirectory)/Engine.cpp$(ObjectSuffix) $(IntermediateDirectory)/Background.cpp$(ObjectSuffix) 



Objects=$(Objects0) 

##
## Main Build Targets 
##
.PHONY: all clean PreBuild PrePreBuild PostBuild MakeIntermediateDirs
all: $(OutputFile)

$(OutputFile): $(IntermediateDirectory)/.d $(Objects) 
	@$(MakeDirCommand) $(@D)
	@echo "" > $(IntermediateDirectory)/.d
	@echo $(Objects0)  > $(ObjectsFileList)
	$(LinkerName) $(OutputSwitch)$(OutputFile) @$(ObjectsFileList) $(LibPath) $(Libs) $(LinkOptions)

MakeIntermediateDirs:
	@test -d ./Debug || $(MakeDirCommand) ./Debug


$(IntermediateDirectory)/.d:
	@test -d ./Debug || $(MakeDirCommand) ./Debug

PreBuild:


##
## Objects
##
$(IntermediateDirectory)/NoMusic.cpp$(ObjectSuffix): NoMusic.cpp $(IntermediateDirectory)/NoMusic.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/NoMusic.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/NoMusic.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/NoMusic.cpp$(DependSuffix): NoMusic.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/NoMusic.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/NoMusic.cpp$(DependSuffix) -MM NoMusic.cpp

$(IntermediateDirectory)/NoMusic.cpp$(PreprocessSuffix): NoMusic.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/NoMusic.cpp$(PreprocessSuffix) NoMusic.cpp

$(IntermediateDirectory)/Player.cpp$(ObjectSuffix): Player.cpp $(IntermediateDirectory)/Player.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Player.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Player.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Player.cpp$(DependSuffix): Player.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Player.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Player.cpp$(DependSuffix) -MM Player.cpp

$(IntermediateDirectory)/Player.cpp$(PreprocessSuffix): Player.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Player.cpp$(PreprocessSuffix) Player.cpp

$(IntermediateDirectory)/Bee.cpp$(ObjectSuffix): Bee.cpp $(IntermediateDirectory)/Bee.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Bee.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Bee.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Bee.cpp$(DependSuffix): Bee.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Bee.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Bee.cpp$(DependSuffix) -MM Bee.cpp

$(IntermediateDirectory)/Bee.cpp$(PreprocessSuffix): Bee.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Bee.cpp$(PreprocessSuffix) Bee.cpp

$(IntermediateDirectory)/Branches.cpp$(ObjectSuffix): Branches.cpp $(IntermediateDirectory)/Branches.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Branches.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Branches.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Branches.cpp$(DependSuffix): Branches.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Branches.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Branches.cpp$(DependSuffix) -MM Branches.cpp

$(IntermediateDirectory)/Branches.cpp$(PreprocessSuffix): Branches.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Branches.cpp$(PreprocessSuffix) Branches.cpp

$(IntermediateDirectory)/Cloud.cpp$(ObjectSuffix): Cloud.cpp $(IntermediateDirectory)/Cloud.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Cloud.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Cloud.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Cloud.cpp$(DependSuffix): Cloud.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Cloud.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Cloud.cpp$(DependSuffix) -MM Cloud.cpp

$(IntermediateDirectory)/Cloud.cpp$(PreprocessSuffix): Cloud.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Cloud.cpp$(PreprocessSuffix) Cloud.cpp

$(IntermediateDirectory)/Log.cpp$(ObjectSuffix): Log.cpp $(IntermediateDirectory)/Log.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Log.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Log.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Log.cpp$(DependSuffix): Log.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Log.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Log.cpp$(DependSuffix) -MM Log.cpp

$(IntermediateDirectory)/Log.cpp$(PreprocessSuffix): Log.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Log.cpp$(PreprocessSuffix) Log.cpp

$(IntermediateDirectory)/game.cpp$(ObjectSuffix): game.cpp $(IntermediateDirectory)/game.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/game.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/game.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/game.cpp$(DependSuffix): game.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/game.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/game.cpp$(DependSuffix) -MM game.cpp

$(IntermediateDirectory)/game.cpp$(PreprocessSuffix): game.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/game.cpp$(PreprocessSuffix) game.cpp

$(IntermediateDirectory)/Draw.cpp$(ObjectSuffix): Draw.cpp $(IntermediateDirectory)/Draw.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Draw.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Draw.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Draw.cpp$(DependSuffix): Draw.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Draw.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Draw.cpp$(DependSuffix) -MM Draw.cpp

$(IntermediateDirectory)/Draw.cpp$(PreprocessSuffix): Draw.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Draw.cpp$(PreprocessSuffix) Draw.cpp

$(IntermediateDirectory)/Gamebject.cpp$(ObjectSuffix): Gamebject.cpp $(IntermediateDirectory)/Gamebject.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Gamebject.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Gamebject.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Gamebject.cpp$(DependSuffix): Gamebject.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Gamebject.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Gamebject.cpp$(DependSuffix) -MM Gamebject.cpp

$(IntermediateDirectory)/Gamebject.cpp$(PreprocessSuffix): Gamebject.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Gamebject.cpp$(PreprocessSuffix) Gamebject.cpp

$(IntermediateDirectory)/Gravestone.cpp$(ObjectSuffix): Gravestone.cpp $(IntermediateDirectory)/Gravestone.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Gravestone.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Gravestone.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Gravestone.cpp$(DependSuffix): Gravestone.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Gravestone.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Gravestone.cpp$(DependSuffix) -MM Gravestone.cpp

$(IntermediateDirectory)/Gravestone.cpp$(PreprocessSuffix): Gravestone.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Gravestone.cpp$(PreprocessSuffix) Gravestone.cpp

$(IntermediateDirectory)/Input.cpp$(ObjectSuffix): Input.cpp $(IntermediateDirectory)/Input.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Input.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Input.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Input.cpp$(DependSuffix): Input.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Input.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Input.cpp$(DependSuffix) -MM Input.cpp

$(IntermediateDirectory)/Input.cpp$(PreprocessSuffix): Input.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Input.cpp$(PreprocessSuffix) Input.cpp

$(IntermediateDirectory)/Tree.cpp$(ObjectSuffix): Tree.cpp $(IntermediateDirectory)/Tree.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Tree.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Tree.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Tree.cpp$(DependSuffix): Tree.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Tree.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Tree.cpp$(DependSuffix) -MM Tree.cpp

$(IntermediateDirectory)/Tree.cpp$(PreprocessSuffix): Tree.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Tree.cpp$(PreprocessSuffix) Tree.cpp

$(IntermediateDirectory)/Axe.cpp$(ObjectSuffix): Axe.cpp $(IntermediateDirectory)/Axe.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Axe.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Axe.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Axe.cpp$(DependSuffix): Axe.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Axe.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Axe.cpp$(DependSuffix) -MM Axe.cpp

$(IntermediateDirectory)/Axe.cpp$(PreprocessSuffix): Axe.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Axe.cpp$(PreprocessSuffix) Axe.cpp

$(IntermediateDirectory)/Update.cpp$(ObjectSuffix): Update.cpp $(IntermediateDirectory)/Update.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Update.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Update.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Update.cpp$(DependSuffix): Update.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Update.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Update.cpp$(DependSuffix) -MM Update.cpp

$(IntermediateDirectory)/Update.cpp$(PreprocessSuffix): Update.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Update.cpp$(PreprocessSuffix) Update.cpp

$(IntermediateDirectory)/Engine.cpp$(ObjectSuffix): Engine.cpp $(IntermediateDirectory)/Engine.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Engine.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Engine.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Engine.cpp$(DependSuffix): Engine.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Engine.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Engine.cpp$(DependSuffix) -MM Engine.cpp

$(IntermediateDirectory)/Engine.cpp$(PreprocessSuffix): Engine.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Engine.cpp$(PreprocessSuffix) Engine.cpp

$(IntermediateDirectory)/Background.cpp$(ObjectSuffix): Background.cpp $(IntermediateDirectory)/Background.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/media/vnvdmit/msdos/tmp/Woodcutter/Background.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/Background.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/Background.cpp$(DependSuffix): Background.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/Background.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/Background.cpp$(DependSuffix) -MM Background.cpp

$(IntermediateDirectory)/Background.cpp$(PreprocessSuffix): Background.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/Background.cpp$(PreprocessSuffix) Background.cpp


-include $(IntermediateDirectory)/*$(DependSuffix)
##
## Clean
##
clean:
	$(RM) -r ./Debug/


