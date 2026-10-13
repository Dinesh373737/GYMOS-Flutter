from pathlib import Path
for file,line,pos in [('features/events/discover_screen.dart',15,1377),('features/progress/progress_screen.dart',8,1443)]:
 s=(Path('gymos2/gymos2_flutter/lib')/file).read_text().splitlines()[line-1];print(file);print(s[max(0,pos-200):pos+150])
