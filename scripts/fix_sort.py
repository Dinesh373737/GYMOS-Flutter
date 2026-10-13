from pathlib import Path
import re
for f in Path('gymos2/gymos2_server/lib/src').rglob('*.dart'):
 if 'generated' in f.parts: continue
 s=f.read_text(encoding='utf8');s=re.sub(r'orderBy:\(t\)=>t\.(\w+),orderDescending:\s*true',r'orderBy:(t)=>t.\1.desc()',s); f.write_text(s,encoding='utf8')
