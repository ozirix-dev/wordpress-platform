<?php
/**
 * Minimal fallback template for the starter site theme.
 */

defined('ABSPATH') || exit;

get_header();
?>
<main class="site-theme-main">
    <?php if (have_posts()) : ?>
        <?php while (have_posts()) : the_post(); ?>
            <article <?php post_class(); ?>>
                <h1><?php the_title(); ?></h1>
                <div>
                    <?php the_content(); ?>
                </div>
            </article>
        <?php endwhile; ?>
    <?php else : ?>
        <article>
            <h1><?php bloginfo('name'); ?></h1>
            <p>Starter site theme is active.</p>
        </article>
    <?php endif; ?>
</main>
<?php
get_footer();
