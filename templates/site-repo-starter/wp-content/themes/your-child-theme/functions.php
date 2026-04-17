<?php
/**
 * Child theme bootstrap.
 *
 * Keep site-specific child theme code in this file as each project grows.
 */

defined('ABSPATH') || exit;

/**
 * Load the parent and child theme styles.
 *
 * Replace or extend the handles and logic in your concrete site repo as needed.
 */
function your_child_theme_enqueue_assets()
{
    $version = wp_get_theme()->get('Version');
    $parent_handle = 'parent-style';

    wp_enqueue_style(
        $parent_handle,
        get_template_directory_uri() . '/style.css'
    );

    wp_enqueue_style(
        'your-child-theme-style',
        get_stylesheet_uri(),
        [$parent_handle],
        (string) $version
    );
}
add_action('wp_enqueue_scripts', 'your_child_theme_enqueue_assets');

/**
 * Site-specific child-theme customizations belong here.
 *
 * Example slots:
 * - register_nav_menus()
 * - add_theme_support()
 * - custom blocks or widgets
 */
