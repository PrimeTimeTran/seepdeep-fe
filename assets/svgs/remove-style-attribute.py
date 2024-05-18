import os
from xml.dom import minidom

def remove_style_attribute(svg_file):
    try:
        doc = minidom.parse(svg_file)
        paths = doc.getElementsByTagName('path')
        for path in paths:
            if path.hasAttribute('style'):
                path.removeAttribute('style')
        with open(svg_file, 'w') as f:
            doc.writexml(f)
            
        print(f"Style attribute removed from {svg_file}")
        
    except Exception as e:
        print(f"Error processing {svg_file}: {e}")

def remove_style_from_svg_files(directory):
    for filename in os.listdir(directory):
        if filename.endswith('.svg'):
            svg_file = os.path.join(directory, filename)
            remove_style_attribute(svg_file)

directory = './assets'
remove_style_from_svg_files(directory)
