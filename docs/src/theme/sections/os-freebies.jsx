import React from 'react';
import { CtaImageButton } from '@trosvald/docusaurus-theme';

export const EsOsFreebies = (props) => {
	return (
		<CtaImageButton
			{...props}
			title='Find more libraries, tools, and design assets free for everyone to use.'
			buttonLabel='Open-source freebies'
			buttonUrl='https://infinum.com/open-source'
			imageUrl='/img/homepage/infinum-open-source.svg'
		/>
	);
};
