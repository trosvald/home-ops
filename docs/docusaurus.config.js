const { themes } = require('prism-react-renderer');

const darkTheme = themes.dracula;

module.exports = {
	title: 'Monolab',
	tagline:
		'RedHat, Kubernetes, Homelabber, System Administrator',
	url: 'https://docs.monosense.io',
	baseUrl: '/',
	favicon: '/img/favicon.svg',
	organizationName: 'trosvald',
	projectName: 'homelab-docs',
	staticDirectories: ['static'],
	scripts: [
		{
			src: 'https://buttons.github.io/buttons.js',
			async: true,
			defer: true,
		},
	],
	themeConfig: {
		navbar: {
			logo: {
				alt: 'monosense Logo',
				src: '/img/logo-229x20.svg',
			},
			items: [
				{
					to: 'docs/welcome',
					activeBasePath: 'docs',
					label: 'Docs',
					position: 'right',
				},
				{
					to: 'guides/welcome',
					activeBasePath: 'guides',
					label: 'Guide',
					position: 'right',
				},
				// {
				// 	to: '/components/welcome',
				// 	activeBasePath: 'components',
				// 	label: 'Components',
				// 	position: 'right',
				// },
				{
					to: '/blog',
					activeBasePath: 'blog',
					label: 'Blog',
					position: 'right',
				},
				{
					to: 'https://gitlab.monosense.io/homelab/home-ops',
					label: 'Repository',
					position: 'right',
				}
			],
		},
		footer: {
			links: [
				{
					title: 'Community',
					items: [
						{
							label: 'Twitter',
							href: 'https://twitter.com/cdisp',
							icon: 'twitter',
						},
					],
				},
			],
			copyright: 'monosense.io. 2024.',

		},
		// algolia: {
		// 	appId: 'JJ9WCXC29M',
		// 	apiKey: '831048ba2d1593f6d40c9d3563a22101',
		// 	indexName: 'infinum_eightshift',
		// 	startUrls: [
		// 		'https://pages.monosense.io',
		// 		'https://pages.monosense.io/docs',
		// 		'https://pages.monosense.io/forms',
		// 	],
		// 	contextualSearch: false,
		// },
		prism: {
			theme: darkTheme,
			additionalLanguages: ['php', 'scss', 'css'],
		},
		colorMode: {
			defaultMode: 'light',
			disableSwitch: true,
			respectPrefersColorScheme: false,
		},
		docs: {
			sidebar: {
				autoCollapseCategories: true,
			},
		},
		trailingSlash: false,
	},
	presets: [
		[
			'@docusaurus/preset-classic',
			{
				docs: {
					sidebarPath: require.resolve('./sidebars.js'),
					sidebarCollapsible: true,
				},
				gtag: {
					trackingID: 'GTM-P5GG5DH',
					anonymizeIP: true,
				},
				theme: {
					customCss: [
						require.resolve('./src/theme/styles.css'),
						require.resolve('@trosvald/docusaurus-theme/dist/style.css'),
					],
				},
				blog: {
					blogTitle: 'Monolab Blog',
					blogDescription:
						'Tutorials and articles about my homelab and experience in real life deployment',
					blogSidebarTitle: 'Latest posts',
					showReadingTime: true,
					postsPerPage: 9,
				},
				sitemap: {
					changefreq: 'weekly',
					priority: 0.5,
				},
			},
		],
	],
	plugins: [
		[
			'@docusaurus/plugin-content-docs',
			{
				id: 'guides',
				path: 'guides',
				routeBasePath: 'guides',
				sidebarPath: require.resolve('./sidebars-guides.js'),
			},
		],
		[
			'@docusaurus/plugin-content-docs',
			{
				id: 'ui-components',
				path: 'ui-components',
				routeBasePath: 'components',
				sidebarPath: require.resolve('./sidebars-components.js'),
			},
		],
		'es-text-loader',
	],
	customFields: {
		keywords: [
			'homelab',
			'kubernetes',
			'linux',
			'flux',
			'gitops',
			'opentofu',
			'ansible',
		],
		image: 'img-why-boilerplate@2x.png',
	},
};
