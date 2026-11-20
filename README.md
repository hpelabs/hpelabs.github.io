# hpelabs

Jekyll-based website for HPE Labs technical content.

## Purpose

This repository hosts practical guides, tutorials, and lab material focused on HPE infrastructure automation and operations.

## Local development

1. Install Ruby and Bundler.
2. Install dependencies:

	bundle install

3. Run locally:

	bundle exec jekyll serve

4. Open:

	http://127.0.0.1:4000/hpelabs/

The homepage pilot is enabled by `home_pilot: true` in `index.html`. Its topic
filters use lab tags; set an optional `home_title` in a lab's front matter for
a shorter card title. The demos page (`post_type: demo`) uses the same cards.
The room pages keep their existing layout.
Search results use the same hover styling as the homepage cards. Click anywhere
on a result to open the lab. Matching text is bold, and dates and tags stay
grouped in the card footer.

## Structure

- `_posts/`: blog and tutorial content
- `_includes/`, `_layouts/`, `_sass/`: theme and rendering customizations
- `assets/`: images, CSS, and JavaScript

## Publishing

Push to the `main` branch of the GitHub repository used for this site, then publish with GitHub Pages according to your Pages settings.
