import React from 'react';
import { useThemeConfig } from '@docusaurus/theme-common';

import { Footer as TrosvaldFooter } from '@trosvald/docusaurus-theme';

function Footer() {
	const { footer } = useThemeConfig();

	return (
		<TrosvaldFooter footer={footer} />
	);
}

export default React.memo(Footer);
