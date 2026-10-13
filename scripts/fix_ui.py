from pathlib import Path
import re,runpy
for path in Path('scripts').glob('ui_*.py'):
 text=path.read_text(encoding='utf8');text=re.sub(r"(put\('[^']+',)'''",r"\1r'''",text);path.write_text(text,encoding='utf8');runpy.run_path(str(path))
f=Path('gymos2/gymos2_flutter/lib/app/app.dart');s=f.read_text();s=s.replace('Widget build(BuildContext context){final profile=ref.watch','Widget build(BuildContext context,WidgetRef ref){final profile=ref.watch');f.write_text(s)
