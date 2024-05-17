---
title: code expression and upload img
date: 2024-05-17
categories: git
layout: post
---
# Markdown synatx
A backtick (`) is used to denote code. To highlight a line of code, wrap it in backticks:  
<pre>
`apt upgrade`
</pre>  
Additionally, you can display code that has been used:  
<pre>  
```python
print("Hello, world!")
```
</pre>

# Image Upload

To describe an image, use the following syntax in Markdown:  
`![description of image](path_to_image) `
<hr>

![upload_img_method](/assets/gitimg/upload_img.png)

<hr>
**Ensure you include the file extension for the image.**  


I found it cumbersome to write long paths, so I used an environment variable.  
<pre>  
`export BLOG='path_to_image_directory`
</pre>

Unfortunately, this did not work in Markdown. 😢  
However, the good news is that writing paths can be easy.  
Simply start with / to navigate from the root directory or use relative paths directly from the current directory.

I attempted to use relative paths, but it didn’t work well because it depends on the current position, which can lead to unexpected errors.  

