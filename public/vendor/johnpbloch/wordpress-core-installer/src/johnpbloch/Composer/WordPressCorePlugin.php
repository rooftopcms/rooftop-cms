<?php

namespace johnpbloch\Composer;

use Composer\Composer;
use Composer\IO\IOInterface;
use Composer\Plugin\PluginInterface;

class WordPressCorePlugin implements PluginInterface {

	/**
	 * Apply plugin modifications to composer
	 *
	 * @param Composer    $composer
	 * @param IOInterface $io
	 */
	public function activate( Composer $composer, IOInterface $io ) {
		$installer = new WordPressCoreInstaller( $io, $composer );
		$composer->getInstallationManager()->addInstaller( $installer );
	}

}
