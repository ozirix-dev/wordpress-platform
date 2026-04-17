<?php
/**
 * Site theme bootstrap.
 *
 * Keep site-specific theme code in this file as each project grows.
 */

defined('ABSPATH') || exit;

/**
 * Register basic site-theme defaults.
 *
 * Extend this in the concrete site repo as needed.
 */
function your_site_theme_setup()
{
    add_theme_support('title-tag');
    add_theme_support('post-thumbnails');
}
add_action('after_setup_theme', 'your_site_theme_setup');

/**
 * Site-specific theme customizations belong here.
 *
 * Example slots:
 * - register_nav_menus()
 * - add_theme_support()
 * - custom blocks or widgets
 */
