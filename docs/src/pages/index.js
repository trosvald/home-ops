import React from 'react';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import useBaseUrl from '@docusaurus/useBaseUrl';
import Layout from '@theme/Layout';
import { Hero, ImageAndText, CtaCards, TextCards, FeatureShowcase, CtaImageButton, icons } from '@trosvald/docusaurus-theme';
import { EsOpenSource } from '../theme/sections/os-projects';
import { EsOsFreebies } from '../theme/sections/os-freebies';

export default function Home() {
	const context = useDocusaurusContext();
	const { siteConfig = {} } = context;

	return (
		<Layout
			title={siteConfig.title}
			description={siteConfig.tagline}
			keywords={siteConfig.customFields.keywords}
			metaImage={useBaseUrl(`img/${siteConfig.customFields.image}`)}
			wrapperClassName='es-footer-white'
		>
			<Hero
				title='Monolab Documentation'
				subtitle='Personal blogs, documentation and notes for my homelab. Focusing on network, operating system, kubernetes and containerization, etc.'
				buttonLabel='Explore'
				buttonUrl='docs/welcome'
				imageUrl='/img/homepage/17918.svg'
				gray
			/>

			{/* <ImageAndText
				title='Homelab Documentation'
				imageUrl='/img/homepage/17918.svg'
				gray
			>
				Eightshift Development kit makes building complex WordPress themes and plugins painless.
				<br /> <br />
				Use and extend our block and component collection to build out dynamic Gutenberg blocks.
				Extract commonly-used UI elements into reusable components.
				Forget about block registration and save callbacks.
				Build a REST route in minutes.
				<br /> <br />
				You&apos;ll never want to go back!
			</ImageAndText> */}

			<div id='get-started'>
				<CtaCards
					title='About me'
					subtitle="18+ years experience on Linux System Administration, love to codes on Spring Framework and managing my K8S & Virtualization homelab on spare times."
					cards={[
						{
							icon: icons.serverBackend,
							text: 'My Hardware',
							buttonLabel: 'Explore',
							buttonUrl: '/docs/network',
						},
						{
							icon: icons.react,
							text: 'My Apps',
							buttonLabel: 'Explore',
							buttonUrl: '/docs/cloud',
						}
					]}
				/>
			</div>
		</Layout>
	);
}
