---
layout: post
title: "Hello world!"
subtitle: "Or how to build a website in an afternoon with GitHub pages and Jekyll"
date: 2021-07-01 16:45:13 -0400
background: '/img/posts/helloworld/jekyll-hyde.jpg'
---

# Introduction
After procrastinating for years, I’ve finally set up a blog to host some of my work. It turned out to be pretty easy, so I figured a good place to start in terms of getting some content up would be to document the process. I’m not going to pretend I’ve done anything particularly interesting or innovative – the most useful resource I found in getting going was a [seven-year old blog post](https://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/) – but this blog is about helping me learn more than anything else, and I hope by writing things up I'm going to understand my site a little better.

# Our tools
This post describes the process for setting up a simple blog using Github Pages and the static-site generator, Jekyll. It will to cover the absolute basics and will require nothing more than a GitHub account and a basic knowledge of how repositories work. You'll need to know how to make changes to files in a repository you own and understand how to fork another repository. If you need help on this front, GitHub has some [useful guides](https://guides.github.com/) it's worth checking out first.

I'm going to describe the quickest and easiest way to get going, which doesn't even require much understanding of Jekyll or for you to have it installed on your machine. I'll begin with a quick overview of GitHub Pages and Jekyll. If you just want the guide, then feel free to [skip ahead](#Building-a-site).

## GitHub Pages
[GitHub Pages](https://pages.github.com/) is a neat service provided by GitHub which provides free, static websites for its users. What do I mean by 'static'? Static site avoid a lot of the complexity of modern web design, they don't need databases, user accounts or scripting. Information is presented 'as stored' to the user and is viewed by everyone in exactly the same way. 

By using GitHub, I get free (as in beer) hosting, whilst not having to get involved in any of the hassle of hosting a site and database, having to learn any new languages or frameworks, or even having to worry too much about security. All the updates to the site are managed through commits, which I'm already using and in need of practice with, but if I'm feeling lazy or despair with Git, it's still totally possible to just drag and drop files up to GitHub.

Sure, things like SquareSpace and Medium exist, but this way is properly free, without banners or restrictions on how many articles users can read, and I get a nice GitHub URL as befits a nerd such as myself. I can always change up for my own domain for free if I like (and probably will), and if I decide I want to host it myself at any point, I can.

## Jekyll
So GitHub pages does the hosting, [Jekyll](https://jekyllrb.com/) builds the site. Jekyll breathes in Markdown (and HTML and CSS, if you like) and breathes out a fully-fledged site ready to go. There are lots of other [static site generators](https://www.techradar.com/best/static-site-generators) out there, but Jekyll is well-supported by GitHub pages[^2] and has been around for ages so has lots of support and templates.

# Building a site
Templates are key here, as we're not going to worry about Jekyll too much and just use an off-the-shelf layout. The basic process for what we'll do involves finding a template, forking it to our GitHub repository, making some configuration tweaks, adding a bit of content, pushing the changes, and we're done.

## Step 1: Fork or download a template
The first thing we need to do is find a template for our blog. There are a bunch of different sites offering Jekyll themes, I used [jekyllthemes.io](https://jekyllthemes.io/free), and [GitHub](https://github.com/topics/jekyll-theme) has a tonne, but you might also want to check out [jamstackthemes.dev](jamstackthemes.dev), [jekyllthemes.org](jekyllthemes.org) or [jekyll-themes.com](jekyll-themes.com).

The site I used offers both free and paid options, but I'm not after anything fancy -- quite the opposite -- so I browse the free collection till I find something I like the look of.

![Choosing a theme at jekyllthemes.io](/img/posts/helloworld/jekyll-themes.png)

Clicking through gives us a link to the [GitHub page](https://github.com/StartBootstrap/startbootstrap-clean-blog-jekyll) which hosts the template. The README.md gives a bunch of instructions for using the theme, which we can completely ignore. The beauty of using GitHub pages is that we can fork the repository, edit our fork and that's our site! 

The next step then, is to fork a template to your own github. 

This step assumes you're working from a github-hosted template. If you were feeling flashy and have paid for something, or used a site which offers files as a download. If this is the case, you'll need to make a new repository and upload the files to there.

## Step 2: Customize the template
You should now have a GitHub repository with a template site in. Great, now we need to turn this from a template to our own site. Fortunately, this is incredibly easy. First, there are couple things we need to configure on GitHub and in our template's code, and then we're already on to writing our first pieces of content.

## Step 3: Hosting the template on GitHub Pages by changing the repository name
For our site to be available to our discerning readership, we need GitHub to understand we want it hosted on Pages. All we need to do this is to change our repository name using the following syntax:

```your_github_username.github.io```

So for me, this would be:

```specialprocedures.github.io```

You can change the name from your repository page by clicking on Settings, and it should be the first setting you see.

![Changing your repository name in Settings](/img/posts/helloworld/github-name.png)

GitHub is now aware that you want the repository to be hosted as a page. In theory this means you should be able to navigate to ```your_github_username.github.io``` in your browser and see it hosted, but I've found that Pages only updates after each commit. So let's make a few tweaks and come back to it in a moment.

## Step 4: Editing the configuration file
In the root directory of your template, you should see a file called ```_config.yml```. The exact fields presented may differ depending on the template you've chosen, but I changed the following:

```
title:              Your website title, this will appear in your title bar and landing page
email:              Your email
description:        A descriptive tag-line for your site
author:             Your name
url:                This is super-important, it should be "https://your_github_username.github.io"
```

Don't forget to update the URL field, I missed that first time round and it broke the site's CSS. There also settings for adding your social media accounts as buttons, to integrate Google Analytics, and to configure markdown options or plugins. Update whatever you want here.

Once you push your changes, this should trigger GitHub into activating your page and you should be able to navigate to your URL to check out your site. Pretty cool!

## Step 5: Updating content
From here on out, it's just about updating content. Different templates come with different files, but my site has an About and Contact page, and a series of posts. Relevant files may be in different folders within your repository. For me, ```about.html``` and ```contact.html``` were in the root, with files for posts located in ```/_posts```. All you need to do to update your files is find the respective files in your GitHub repository, edit them using your preferred method, and push the changes to your repository.

Files can be edited using Markdown, HTML, or even plain text. All of my template files were saved at ```.html```, but if you want to edit in Markdown, you'll need to change the extension to ```.md```. Each file in your template should come with a header containing a series of fields (e.g., layout, title, date) which will update relevant parts of the page, and then after the header comes your content. Here's an example from this very post:

![Writing a blog post](/img/posts/helloworld/writing-content.png)

### Two important things on content
Creating content for your blog is very straightforward, which to me is one of the the main attractions of this approach. There are however a couple of things that you need to be aware of:

#### Filename format for posts
If you're creating a blog-type site, Jekyll expects your files to be named in a particular way. Make sure to name blog posts using the following syntax: ```YYYY-MM-DD-title.md``` or ```YYYY-MM-DD-title.html``` (depending on whether you're using Markdown or HTML) for example ```2021-07-01-helloworld.md```. This way, Jekyll will know it's looking at a post and will manage the content correctly.

#### Updates and browser cache
You may find that after pushing a change to your repository, updates may not be visible on your page when you visit it in your browser. If this is the case, try [clearing your browser cache](https://www.digitaltrends.com/computing/how-to-clear-your-browser-cache/) waiting a few minutes and trying again.

## Step 6: Over to you
This guide intends to get the reader up and running quickly using GitHub Pages and Jekyll, but there's far more you'll want to do once you've got your site going. Some of the first things I did at this stage change were working out how to change template fonts and stock images. You may want to do the same, or maybe try and add new functionality, such as [categories](https://blog.webjeda.com/jekyll-categories/). It's also pretty trivial to add your own [custom domain name](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site). I spent an afternoon poking around with my code, learning a little CSS, and breaking a few things before I was happy with the final result.

Fortunately, both GitHub pages and Jekyll are very mature products and there are lots of guides and documentation to help. You might want to check out some of the following:

- [Jekyll documentation](https://jekyllrb.com/docs/)
- [GitHub Pages documentation](https://pages.github.com/)
- [Build a blog with GitHub Pages and Jekyll by Smashing Magazine](https://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/)

Happy hacking!



[^1]: Looks like DreamWeaver's [still going](https://www.adobe.com/products/dreamweaver.html)! I'll pass on the USD 20.99 a month though.

[^2]: It's actually built by GitHub founder [Tom Preston-Werner](https://tom.preston-werner.com/).