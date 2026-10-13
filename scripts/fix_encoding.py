from pathlib import Path
for f in Path('gymos2/gymos2_server/lib/src').rglob('*.dart'):
 if 'generated' in f.parts: continue
 raw=f.read_bytes()
 try: text=raw.decode('utf8')
 except UnicodeDecodeError: text=raw.decode('cp1252')
 text=text.replace('orderDescending:true','orderDescending: true')
 f.write_text(text,encoding='utf8')
