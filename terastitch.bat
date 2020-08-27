:: Step 1 (Import)
set volumePath="C:\Users\julia\Desktop\test"
set ref1="x"
set ref2="y"
set ref3="z"
set vxl1="1.43"
set vxl2="1.43"
set vxl3="5.0"
set imin_regex="000000.tif"
set imin_plugin="tiff3D"
set volin_plugin="TiledXY|3Dseries"
terastitcher --import --volin=%volumePath% --ref1=%ref1% --ref2=%ref2% --ref3=%ref3% --vxl1=%vxl1% --vxl2=%vxl2%^
 --vxl3=%vxl3% --volin_plugin=%volin_plugin% --imin_regex=%imin_regex% --imin_plugin=%imin_plugin%

:: Step 2 (Align)
set projin=%volumePath%\xml_import.xml
set /a oH=245
set /a oV=205
set /a sH=99
set /a sV=99
set /a sD=99
terastitcher --displcompute --projin=%projin% --oH=%oH% --oV=%oV% --sH=%sH% --sV=%sV% --sD=%sD%

:: Step 3 (Project)
set projin=%volumePath%\xml_displcomp.xml
terastitcher --displproj --projin=%projin%

:: Step 4 (Threshold)
set projin=%volumePath%\xml_displproj.xml
set threshold="0.7"
terastitcher --displthres --projin=%projin% --threshold=%threshold%

:: Step 5 (Place)
set projin=%volumePath%\xml_displthres.xml
terastitcher --placetiles --projin=%projin%

:: Step 6 (Merge)
set projin=%volumePath%\xml_merging.xml
set volout="C:\Users\julia\Desktop\result\stitched.tif"
set volout_plugin="TiledXY|3Dseries"
set imout_format="tif"
terastitcher --merge --projin=%projin% --volout=%volout% --volout_plugin=%volout_plugin% --imout_format=%imout_format%
