' <# License>------------------------------------------------------------
' 
'  Copyright (c) 2018 Shinnosuke Yakenohara
' 
'  This program is free software: you can redistribute it and/or modify
'  it under the terms of the GNU General Public License as published by
'  the Free Software Foundation, either version 3 of the License, or
'  (at your option) any later version.
' 
'  This program is distributed in the hope that it will be useful,
'  but WITHOUT ANY WARRANTY; without even the implied warranty of
'  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'  GNU General Public License for more details.
' 
'  You should have received a copy of the GNU General Public License
'  along with this program.  If not, see <http://www.gnu.org/licenses/>
' 
' -----------------------------------------------------------</License #>

'�ݒ�
styleStr_DirStart = """"
styleStr_DirEnd = """"
styleStr_MiddleOfList = "��"
styleStr_EndOfList = "��"

'���C�u��������I�u�W�F�N�g����
Set ShellObj = CreateObject("WScript.Shell")
Set FSObj = createObject("Scripting.FileSystemObject")
Set folderArrayList = CreateObject("System.Collections.ArrayList")
Set fileArrayList = CreateObject("System.Collections.ArrayList")

parentDirStr = ""

For Each arg In WScript.Arguments
    
    '�f�B���N�g������ۑ�
    If parentDirStr <> "" Then '2��ڈȍ~�̃f�B���N�g���̏ꍇ

        '�����̃f�B���N�g�����w�肵�Ă��Ȃ����ǂ����`�F�b�N
        If parentDirStr <> FSObj.getParentFolderName(arg) Then
            WScript.Echo "�����f�B���N�g���ɓn��p�����[�^�w��͂ł��܂���"
            WScript.Quit '���f
        End If

    Else '���ڂ̃��[�v�̏ꍇ�̓f�B���N�g������ۑ�
        parentDirStr = FSObj.getParentFolderName(arg)

    End If

    If FSObj.FolderExists(arg) Then '�t�H���_�̏ꍇ
        Call folderArrayList.Add(FSObj.GetFileName(arg))

    Else '�t�@�C���̏ꍇ
        Call fileArrayList.Add(FSObj.GetFileName(arg))

    End If
    
Next

'���O���ŕ��בւ�
Call folderArrayList.Sort
Call fileArrayList.Sort

'�������Ĕz����擾
folderArrayList.AddRange(fileArrayList)
names = folderArrayList.ToArray

'ItemList�̍쐬
printStr = styleStr_DirStart & parentDirStr & styleStr_DirEnd
itrMx = UBound(names)
For itr = 0 To (itrMx - 1)
    printStr = printStr & vbCrLf & styleStr_MiddleOfList & names(itr)
Next    
printStr = printStr & vbCrLf & styleStr_EndOfList & names(itr)

'�N���b�v�{�[�h�ɃR�s�[
ShellObj.Exec("clip").StdIn.Write printStr
