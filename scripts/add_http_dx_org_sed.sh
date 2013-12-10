!/bin/sh
# Mini-script to turn dois: exported from Zotero 'generate a bibliography' into clickable http links
# For emailing around Journal Club bibliographies

# Reminder: Preferred form is Chcagi Manual of Style (full note)
# (*) Bibliography
# Copy to clipboard

sed "s#doi:#http://dx.doi.org/#g"
