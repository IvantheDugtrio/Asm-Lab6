ALL: LAB6.EXE

CLEAN:
	-@erase LAB6.EXE
	-@erase LAB6.ILK
	-@erase LAB6.PDB
	-@erase LAB6.OBJ
	-@erase LAB6.LST
	
LAB6.ASM:

LAB6.OBJ: LAB6.ASM
	ml /c /coff /Zi LAB6.ASM
	
LAB6.EXE: LAB6.OBJ 
	link /debug /subsystem:console /out:LAB6.EXE /entry:start LAB6.OBJ KERNEL32.LIB IO.OBJ